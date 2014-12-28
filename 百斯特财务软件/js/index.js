var gui = require("nw.gui");
var win = gui.Window.get();
var loginWindow;
var mainWindow;

$(document).ready(function() {
    initTray();
    openLoginWindow();
});

function quitApp() {
    gui.App.quit();
}

function doLogout() {

}

function initTray() {
    var tray = new gui.Tray({
        title: gui.App.manifest.name,
        icon: "img/tray.png"
    });
    var menu = new gui.Menu();
    var logout = new gui.MenuItem({
        label: '注销'
    });
    var exit = new gui.MenuItem({
        label: '退出'
    });
    menu.append(logout);
    menu.append(exit);
    tray.menu = menu;
    logout.on("click", doLogout);
    exit.on("click", quitApp);

    tray.on("click", function() {
        if (mainWindow) {
            mainWindow.show();
            mainWindow.focus();
        }
    });
}

function openLoginWindow() {
    loginWindow = gui.Window.open('windows/login.html', {
        "position": 'center',
        "width": 350,
        "height": 485,
        "resizable": false,
        "icon": "img/icon.png",
        "toolbar": false,
        "frame": false,
        "transparent": true,
        "fullscreen": false,
        "show": false
    });
    loginWindow.on("loaded", initLoginWindow);
}

function initLoginWindow() {
    loginWindow.setTransparent(true);
    loginWindow.show();
    loginWindow.window.baseWindow = window;
}

function openMainWindow() {
    mainWindow = gui.Window.open('windows/main.html', {
        "position": 'center',
        "width": screen.availWidth,
        "height": screen.availHeight,
        "min_width": 1000,
        "min_height": 500,
        "resizable": true,
        "icon": "img/icon.png",
        "toolbar": false,
        "frame": true,
        "transparent": false,
        "fullscreen": false,
        "show": false
    });
    mainWindow.on("loaded", initMainWindow);
}

function initMainWindow() {
    mainWindow.on("close", quitApp);
    mainWindow.show();
    mainWindow.focus();
    mainWindow.window.baseWindow = window;
}
