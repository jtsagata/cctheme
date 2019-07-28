add_library(cpp-colors INTERFACE)
target_include_directories(cpp-colors INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/include/)


#file(GLOB CPP_COLOR_SOURCES "*.h")

#add_library(cpp-colors ${CPP_COLOR_SOURCES})
#target_include_directories(cpp-colors INTERFACE
#        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}
#        )
#
#set_target_properties(cpp-colors PROPERTIES LINKER_LANGUAGE CXX)

#target_compile_features(fmt-header-only INTERFACE ${FMT_REQUIRED_FEATURES})
#
#target_include_directories(fmt-header-only INTERFACE
#        $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
#        $<INSTALL_INTERFACE:include>)