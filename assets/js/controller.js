/** @format */
const $ = document.querySelector.bind(document);
const iframeEl = $("#iframes_play");

var linkVideo = localStorage["link"];
// https://player.vimeo.com/video/839199639
iframeEl.src = linkVideo || "";
let idVideo = iframeEl.src.match(/\/(\d+)$/)[1];

let controllerVimeo = new Vimeo.Player(iframeEl);

controllerVimeo.on("timeupdate", function (e) {
    try {
        window.flutter_inappwebview.callHandler(
            "updateProgress",
            idVideo,
            e.percent
        );
    } catch (err) {
        alert(err);
    }
    // Perform any actions you want when the video starts playing.
});
