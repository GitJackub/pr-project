#####################################################################
## QuickStudioApplicationModule:
#####################################################################

qt_add_library(QuickStudioUtils STATIC)
set(PROJECT_VERSION 1.0)

qt6_add_qml_module(QuickStudioUtils
    URI QtQuick.Studio.Utils
    VERSION ${PROJECT_VERSION}
    # DESIGNER_SUPPORTED optional - can be left or removed
    PAST_MAJOR_VERSIONS 1
    SOURCES
        quickstudiocsvtablemodel.cpp
        quickstudiofilereader.cpp
        quickstudiocsvtablemodel_p.h
        quickstudiofilereader_p.h
    QML_FILES
        JsonListModel.qml
        JsonBackend.qml
        ChildListModel.qml
    RESOURCE_PREFIX /studio/utils
)

target_link_libraries(QuickStudioUtils
    PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick
)

target_include_directories(QuickStudioUtils
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}
)
