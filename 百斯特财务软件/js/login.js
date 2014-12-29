var gui = require("nw.gui");
var win = gui.Window.get();
var md5 = require('MD5');
var startPosX;
var startPosY;
var ladda;
var baseWindow;

initDragZone();

win.on("loaded", init);

win.showDevTools("", false);

function init() {
    $("#closeBtn").on("click", quitApp);
    $("#submitBtn").on("click", doLogin);

    if (localStorage.auto) {
        $("#autoLogin").attr("checked", "checked");
        $("#username").val(localStorage.un);
        $("#password").val(localStorage.pw);
        $("#submitBtn").trigger("click");
    }
}

function quitApp() {
    baseWindow.quitApp();
}

function doLogin() {
    var un = $("#username").val();
    var pw = $("#password").val();
    un = un.replace(/\s+/g, "");
    pw = pw.replace(/\s+/g, "");
    if (un == "" || pw == "") {
        $.scojs_message('帐号或密码不能为空!', $.scojs_message.TYPE_ERROR);
        return;
    }
    $("#username").attr("readonly", "readonly");
    $("#password").attr("readonly", "readonly");
    $("#autoLogin").attr("disabled", "disabled");
    ladda = Ladda.create(this);
    ladda.start();
    $.post(gui.App.manifest.server + gui.App.manifest.app + "/login", {
        un: un,
        pw: md5(pw)
    }, function(body) {
        if (!body || !body.success) {
            $.scojs_message(body.msg, $.scojs_message.TYPE_ERROR);
            $("#username").removeAttr("readonly");
            $("#password").removeAttr("readonly");
            $("#autoLogin").removeAttr("disabled");
            ladda.stop();
        } else {
            if ($("#autoLogin").is(":checked")) {
                localStorage.un = $("#username").val();
                localStorage.pw = $("#password").val();
                localStorage.auto = true;
            } else {
                localStorage.removeItem("auto");
            }
            localStorage.user = JSON.stringify(body.data);
            baseWindow.loginSuccess();
        }
    });
}

function initDragZone() {
    $("#dragZone").on("mousedown", function(event) {
        startPosX = event.pageX;
        startPosY = event.pageY;
        $("#dragZone").css("cursor", "pointer");

        $(document).on("mousemove", function(event) {
            var offsetX = event.pageX - startPosX;
            var offsetY = event.pageY - startPosY;
            win.moveBy(offsetX, offsetY);
        });
    });

    $(document).on("mouseup", function(event) {
        $(document).off("mousemove");
        $("#dragZone").css("cursor", "default");
    });

    $(window).on("keydown", function(event) {
        if (event.keyCode == 13) {
            $("#submitBtn").trigger("click");
        }
    });
}
