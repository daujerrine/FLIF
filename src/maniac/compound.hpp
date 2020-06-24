/*
FLIF - Free Lossless Image Format

Copyright 2010-2016, Jon Sneyers & Pieter Wuille

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

#pragma once

#define __PLN__ printf("At: [%s] %s, %d\n", __func__, __FILE__, __LINE__);
#define MSG(fmt, ...) printf("[%s] " fmt, __func__, ##__VA_ARGS__)
#include <vector>
#include <math.h>
#include <stdint.h>
#include "symbol.hpp"
#include "../image/image.hpp"


typedef  ColorVal  PropertyVal;
typedef  std::vector<std::pair<PropertyVal,PropertyVal> > Ranges;
typedef  std::vector<PropertyVal> Properties;

// inner nodes
class PropertyDecisionNode
{
public:
    int8_t property;         // -1 : leaf node, childID unused
    // 0..nb_properties-1 : childID refers to left branch  (in inner_node)
    //                      childID+1 refers to right branch
    int16_t count;
    PropertyVal splitval;
    uint32_t childID;
    uint32_t leafID;
    // probably safe to use only uint16
    //uint16_t childID;
    //uint16_t leafID;
    PropertyDecisionNode(int p=-1, int s=0, int c=0) : property(p), count(0), splitval(s), childID(c), leafID(0) {}
};

class Tree : public std::vector<PropertyDecisionNode>
{
public:
    Tree() : std::vector<PropertyDecisionNode>(1, PropertyDecisionNode()) {}
};

// leaf nodes when tree is known
template <typename BitChance, int bits> class FinalCompoundSymbolChances
{
public:
    SymbolChance<BitChance, bits> realChances;

    FinalCompoundSymbolChances() { }

    const SymbolChance<BitChance, bits> &chances() const
    {
        return realChances;
    }
};


template <typename BitChance, typename RAC, int bits> class FinalCompoundSymbolBitCoder
{
public:
    typedef typename BitChance::Table Table;

private:
    const Table &table;
    RAC &rac;
    FinalCompoundSymbolChances<BitChance, bits> &chances;

    void inline updateChances(const SymbolChanceBitType type, const int i, bool bit)
    {
        BitChance& real = chances.realChances.bit(type,i);
        real.put(bit, table);
    }

public:
    FinalCompoundSymbolBitCoder(const Table &tableIn, RAC &racIn, FinalCompoundSymbolChances<BitChance, bits> &chancesIn) : table(tableIn), rac(racIn), chances(chancesIn) {}

    bool inline read(const SymbolChanceBitType type, const int i = 0)
    {
        BitChance& ch = chances.realChances.bit(type, i);
        bool bit = rac.read_12bit_chance(ch.get_12bit());
        //MSG("type: %d i: %d bitchance: %d\n", type, i, ch.get_12bit());
        updateChances(type, i, bit);
        return bit;
    }

#ifdef HAS_ENCODER
    void inline write(const bool bit, const SymbolChanceBitType type, const int i = 0);
#endif
};



template <typename BitChance, typename RAC, int bits> class FinalCompoundSymbolCoder
{
private:
    typedef typename FinalCompoundSymbolBitCoder<BitChance, RAC, bits>::Table Table;
    RAC &rac;
    const Table table;

public:

    FinalCompoundSymbolCoder(RAC& racIn, int cut = 2, int alpha = 0xFFFFFFFF / 19) : rac(racIn), table(cut,alpha) {}

    int read_int(FinalCompoundSymbolChances<BitChance, bits> &chancesIn, int min, int max)
    {
        FinalCompoundSymbolBitCoder<BitChance, RAC, bits> bitCoder(table, rac, chancesIn);
        int val = reader<bits>(bitCoder, min, max);
        return val;
    }
    int read_int(FinalCompoundSymbolChances<BitChance, bits> &chancesIn, int nbits)
    {
        FinalCompoundSymbolBitCoder<BitChance, RAC, bits> bitCoder(table, rac, chancesIn);
        int val = reader(bitCoder, nbits);
        return val;
    }

#ifdef HAS_ENCODER
    void write_int(FinalCompoundSymbolChances<BitChance, bits>& chancesIn, int min, int max, int val);
    void write_int(FinalCompoundSymbolChances<BitChance, bits>& chancesIn, int nbits, int val);
#endif
};



template <typename BitChance, typename RAC, int bits> class FinalPropertySymbolCoder
{
private:
    FinalCompoundSymbolCoder<BitChance, RAC, bits> coder;
    //Ranges range;
    unsigned int nb_properties;
    std::vector<FinalCompoundSymbolChances<BitChance,bits> > leaf_node;
    Tree &inner_node;
    FinalCompoundSymbolChances<BitChance,bits> inline &find_leaf(const Properties &properties) ATTRIBUTE_HOT {
        Tree::size_type pos = 0;
        while(inner_node[pos].property != -1)
        {
            printf("pos = %u, prop = %d\n", pos, inner_node[pos].property);
            if (inner_node[pos].count < 0) {
                if (properties[inner_node[pos].property] > inner_node[pos].splitval) {
                    pos = inner_node[pos].childID;
                } else {
                    pos = inner_node[pos].childID+1;
                }
            } else if (inner_node[pos].count > 0) {
                assert(inner_node[pos].leafID >= 0);
                assert((unsigned int)inner_node[pos].leafID < leaf_node.size());
                inner_node[pos].count--;
                break;
            } else if (inner_node[pos].count == 0) {
                inner_node[pos].count--;
                FinalCompoundSymbolChances<BitChance,bits> &result = leaf_node[inner_node[pos].leafID];
                uint32_t old_leaf = inner_node[pos].leafID;
                uint32_t new_leaf = leaf_node.size();
                FinalCompoundSymbolChances<BitChance,bits> resultCopy = result;
                leaf_node.push_back(resultCopy);
                inner_node[inner_node[pos].childID].leafID = old_leaf;
                inner_node[inner_node[pos].childID+1].leafID = new_leaf;
                if (properties[inner_node[pos].property] > inner_node[pos].splitval) {
                    return leaf_node[old_leaf];
                } else {
                    return leaf_node[new_leaf];
                }
            }
        }
        printf("leaf: %d\n", inner_node[pos].leafID);
        return leaf_node[inner_node[pos].leafID];
    }

public:
    FinalPropertySymbolCoder(RAC& racIn, Ranges &rangeIn, Tree &treeIn, int FLIF_UNUSED(ignored_split_threshold) = 0, int cut = 4, int alpha = 0xFFFFFFFF / 20) :
        coder(racIn, cut, alpha),
//        range(rangeIn),
        nb_properties(rangeIn.size()),
        leaf_node(1,FinalCompoundSymbolChances<BitChance,bits>()),
        inner_node(treeIn)
    {
        inner_node[0].leafID = 0;
    }

    int read_int(const Properties &properties, int min, int max) ATTRIBUTE_HOT {
        if (min == max)
        {
            return min;
        }
        assert(properties.size() == nb_properties);
        FinalCompoundSymbolChances<BitChance,bits> &chances = find_leaf(properties);
        return coder.read_int(chances, min, max);
    }


    int read_int(const Properties &properties, int nbits)
    {
        assert(properties.size() == nb_properties);
        FinalCompoundSymbolChances<BitChance,bits> &chances = find_leaf(properties);
        return coder.read_int(chances, nbits);
    }

#ifdef HAS_ENCODER
    void write_int(const Properties &properties, int min, int max, int val);
    void write_int(const Properties &properties, int nbits, int val);
    static void simplify(FLIF_UNUSED(int divisor)=CONTEXT_TREE_COUNT_DIV, FLIF_UNUSED(int min_size)=CONTEXT_TREE_MIN_SUBTREE_SIZE, FLIF_UNUSED(int plane)=0) {}
    static uint64_t compute_total_size()
    {
        return 0;
    }
#endif

};



template <typename BitChance, typename RAC> class MetaPropertySymbolCoder
{
public:
    typedef SimpleSymbolCoder<BitChance, RAC, 18> Coder;
private:
    std::vector<Coder> coder;
    const Ranges range;
    unsigned int nb_properties;
    uint_fast32_t depth;

public:
    MetaPropertySymbolCoder(RAC &racIn, const Ranges &rangesIn, int cut = 2, int alpha = 0xFFFFFFFF / 19) :
        coder(3,Coder(racIn, cut, alpha)),
        range(rangesIn),
        nb_properties(rangesIn.size())
    {
        printf("PropRanges:\n");
        for(int i = 0; i < range.size(); ++i)
            printf("%d, %d\n", range[i].first, range[i].second);
        for (unsigned int i=0; i<nb_properties; i++) {
            assert(range[i].first <= range[i].second);
        }
    }

#ifdef HAS_ENCODER
    void write_subtree(int pos, Ranges &subrange, const Tree &tree);
    void write_tree(const Tree &tree);
#endif

    bool read_subtree(int pos, Ranges &subrange, Tree &tree)
    {
        PropertyDecisionNode &n = tree[pos];
        //if (pos >= 50)
        //    return false;
        int p = n.property = coder[0].read_int2(0,nb_properties)-1;
        if (p != -1) {
            /*if(pos > 170) {
                for(unsigned int i = 0; i < subrange.size(); ++i)
                    printf("%u: (%d, %d) ", i, subrange[i].first, subrange[i].second);
                printf("\n");
            }*/
            int oldmin = subrange[p].first;
            int oldmax = subrange[p].second;
            if (oldmin >= oldmax) {
                e_printf( "Invalid tree. Aborting tree decoding.\n");
                return false;
            }
            n.count = coder[1].read_int2(CONTEXT_TREE_MIN_COUNT, CONTEXT_TREE_MAX_COUNT); // * CONTEXT_TREE_COUNT_QUANTIZATION;
            assert(oldmin < oldmax);
            int splitval = n.splitval = coder[2].read_int2(oldmin, oldmax-1);
            int childID = n.childID = tree.size();
            MSG("%d\t%d\t%d\t%d\t%u\t%d\t%d\n", pos, p, n.count, n.splitval, n.childID, oldmin, oldmax);
            //v_printf( "Pos %i: prop %i splitval %i [oldmin %i.. oldmax %i]\n", pos, n.property, splitval, oldmin, oldmax-1);
            tree.push_back(PropertyDecisionNode());
            tree.push_back(PropertyDecisionNode());
            // > splitval
            ++depth;
            subrange[p].first = splitval+1;
            if (!read_subtree(childID, subrange, tree)) return false;
            MSG("To right child cur: %d to: %d pvalue: %d\n", pos, childID+1, p);
            // <= splitval
            subrange[p].first = oldmin;
            subrange[p].second = splitval;
            if (!read_subtree(childID+1, subrange, tree)) return false;
            MSG("Back cur: %d pvalue %d\n", pos, p);
            subrange[p].second = oldmax;
        } else
            MSG("Leaf %d\n", pos);
        --depth;
        return true;
    }
    bool read_tree(Tree &tree)
    {
        depth = 1000;
        Ranges rootrange(range);
        tree.clear();
        MSG("   pos\tprop\tcount\tsplitv\tchild\tomin\tomax\n");
        tree.push_back(PropertyDecisionNode());
        if (read_subtree(0, rootrange, tree)) {
            v_printf(6,"Read MANIAC tree with %u inner nodes.\n",(unsigned int) tree.size());
            return true;
        } else return false;
        //return read_subtree(0, rootrange, tree);
    }
};

#ifdef HAS_ENCODER
#include "compound_enc.hpp"
#endif
