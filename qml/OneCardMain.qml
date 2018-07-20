import VPlay 2.0
import QtQuick 2.0
import "scenes"
import "common"
import Qt.labs.settings 1.0
import VPlayPlugins 1.0

GameWindow {
    id: window
    height: 640
    width: 960

    title: gameNetwork.user.deviceId + " - " + gameNetwork.user.name

    readonly property string gameTitle: "One Card!"
    property MenuScene menuScene: sceneLoader.item && sceneLoader.item.menuScene
    property GameScene gameScene: sceneLoader.item && sceneLoader.item.gameScene
    property alias loadingScene: loadingScene
    readonly property int gamesPlayed: menuScene ? menuScene.localStorage.gamesPlayed : 0

    //在运行时创建和移动实体
    EntityManager {
        id: entityManager
        entityContainer: gameScene
    }

    //主页面字体
    FontLoader {
        id: standardFont
        source: "../assets/fonts/agoestoesan.ttf"
    }


    VPlayGameNetwork {
        id: gameNetwork
        clearAllUserDataAtStartup: system.desktopPlatform && enableMultiUserSimulation
        gameId: Constants.gameId

        property int counterAppInstances: 0
    }

    VPlayMultiplayer {
        id: multiplayer

        playerCount: 4
        startGameWhenReady: true
        gameNetworkItem: gameNetwork
        onGameStarted: {
            if(menuScene) {
                menuScene.localStorage.setGamesPlayed(gamesPlayed + 1)
                window.state = "game"
            }
        }
    }

    GoogleAnalytics {
        id: ga
    }

    Flurry {
        id: flurry
    }

    // loadingscene,在开始界面初始化
    state: "loading"
    activeScene: loadingScene

    LoadingScene {
        id: loadingScene
    }

   //当显示完成菜单时，其他场景在运行时加载
    Loader {
        id: sceneLoader
        onLoaded: window.state = "menu"

        // 在0.5秒后开始加载
        Timer {
            id: loadingTimer
            interval: 500
            onTriggered: sceneLoader.source = Qt.resolvedUrl("OneCardMainItem.qml")
        }
    }

    Component.onCompleted: loadingTimer.start() //在主界面完成时开始加载其他场景

    states: [
        State {
            name: "loading"
            PropertyChanges {target: loadingScene; opacity: 1}
            PropertyChanges {target: window; activeScene: loadingScene}
        },
        State {
            name: "menu"
            PropertyChanges {target: menuScene; opacity: 1}
            PropertyChanges {target: window; activeScene: menuScene}
        },
        State {
            name: "game"
            PropertyChanges {target: gameScene; opacity: 1}
            PropertyChanges {target: window; activeScene: gameScene}
        }
    ]
}

