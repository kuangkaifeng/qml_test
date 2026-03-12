# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\LightSculpt_win_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\LightSculpt_win_autogen.dir\\ParseCache.txt"
  "LightSculpt_win_autogen"
  "libdxfrw-LC2.2.0\\CMakeFiles\\dxfrw_autogen.dir\\AutogenUsed.txt"
  "libdxfrw-LC2.2.0\\CMakeFiles\\dxfrw_autogen.dir\\ParseCache.txt"
  "libdxfrw-LC2.2.0\\dwg2dxf\\CMakeFiles\\dwg2dxf_autogen.dir\\AutogenUsed.txt"
  "libdxfrw-LC2.2.0\\dwg2dxf\\CMakeFiles\\dwg2dxf_autogen.dir\\ParseCache.txt"
  "libdxfrw-LC2.2.0\\dwg2dxf\\dwg2dxf_autogen"
  "libdxfrw-LC2.2.0\\dxfrw_autogen"
  )
endif()
