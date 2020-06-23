# CMake generated Testfile for 
# Source directory: /home/turpentine/Documents/sources/FLIF/src
# Build directory: /home/turpentine/Documents/sources/FLIF/src/build
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(libtest "/home/turpentine/Documents/sources/FLIF/src/build/libtest" "dummy.flif")
add_test(libtest_static "/home/turpentine/Documents/sources/FLIF/src/build/libtest_static" "dummy.flif")
add_test(roundtrip1 "/home/turpentine/Documents/sources/FLIF/src/../tools/test-roundtrip.sh" "/home/turpentine/Documents/sources/FLIF/src/../tools/2_webp_ll.png" "2_webp_ll.flif" "decoded_2_webp_ll.png")
add_test(roundtrip2 "/home/turpentine/Documents/sources/FLIF/src/../tools/test-roundtrip.sh" "/home/turpentine/Documents/sources/FLIF/src/../tools/kodim01.png" "kodim01.flif" "decoded_kodim01.png")
add_test(roundtrip3 "/home/turpentine/Documents/sources/FLIF/src/../tools/test-roundtrip_anim.sh" "/home/turpentine/Documents/sources/FLIF/src/../tools/endless_war.gif" "endless_war.flif")
