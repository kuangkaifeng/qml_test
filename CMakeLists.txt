cmake_minimum_required(VERSION 3.16)

project(LightSculpt_win VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)



set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core Quick Widgets)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core Quick Widgets)

set(PROJECT_SOURCES
        main.cpp
        ${CMAKE_SOURCE_DIR}/qml_src/qml.qrc
)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/libdxfrw-LC2.2.0/CMakeLists.txt")
    add_subdirectory(libdxfrw-LC2.2.0)  # 添加 libdxfrw 子目录，它应该会生成 dxfrw 库目标
    # 注意：如果 libdxfrw 的 CMakeLists 没有导出合适的库目标，可能需要手动设置
    # 这里假设它生成了名为 dxfrw 的库目标
    set(LIBDXFRW_TARGET dxfrw)
else()
    # 方式二：如果 libdxfrw 已安装在系统中，可以尝试用 find_library 查找
    find_library(LIBDXFRW_LIBRARY NAMES dxfrw libdxfrw REQUIRED)
    find_path(LIBDXFRW_INCLUDE_DIR NAMES libdxfrw.h PATH_SUFFIXES libdxfrw)
    if(LIBDXFRW_LIBRARY AND LIBDXFRW_INCLUDE_DIR)
        add_library(dxfrw UNKNOWN IMPORTED)
        set_target_properties(dxfrw PROPERTIES
            IMPORTED_LOCATION ${LIBDXFRW_LIBRARY}
            INTERFACE_INCLUDE_DIRECTORIES ${LIBDXFRW_INCLUDE_DIR}
        )
        set(LIBDXFRW_TARGET dxfrw)
    else()
        message(FATAL_ERROR "未找到 libdxfrw，请检查路径或将其放在 libdxfrw 目录下")
    endif()
endif()

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(LightSculpt_win
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
        image.qrc
        datahandler.h
        datahandler.cpp
        c++_src/dxfparser.cpp
        c++_src/dxfparser.h

    )
# Define target properties for Android with Qt 6 as:
#    set_property(TARGET LightSculpt_win APPEND PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
#                 ${CMAKE_CURRENT_SOURCE_DIR}/android)
# For more information, see https://doc.qt.io/qt-6/qt-add-executable.html#target-creation
else()
    if(ANDROID)
        add_library(LightSculpt_win SHARED
            ${PROJECT_SOURCES}
        )
# Define properties for Android with Qt 5 after find_package() calls as:
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
    else()
        add_executable(LightSculpt_win
          ${PROJECT_SOURCES}
        )
    endif()
endif()

target_link_libraries(LightSculpt_win
    PRIVATE Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::Widgets
    ${LIBDXFRW_TARGET}
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
if(${QT_VERSION} VERSION_LESS 6.1.0)
  set(BUNDLE_ID_OPTION MACOSX_BUNDLE_GUI_IDENTIFIER com.example.LightSculpt_win)
endif()
set_target_properties(LightSculpt_win PROPERTIES
    ${BUNDLE_ID_OPTION}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

include(GNUInstallDirs)
install(TARGETS LightSculpt_win
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

if(QT_VERSION_MAJOR EQUAL 6)
    qt_import_qml_plugins(LightSculpt_win)
    qt_finalize_executable(LightSculpt_win)
endif()
message("CMAKE_SOURCE_DIR:${CMAKE_SOURCE_DIR}")


