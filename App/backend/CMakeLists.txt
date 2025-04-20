# backend/CMakeLists.txt

add_library(Backend STATIC
    TcpClient.cpp
    TcpClient.h
)

target_link_libraries(Backend
    Qt6::Core
    Qt6::Network
)

target_include_directories(Backend PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
