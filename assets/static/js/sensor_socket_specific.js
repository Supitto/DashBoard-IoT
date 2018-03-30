// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/web/endpoint.ex":
import "phoenix_html"
import {Socket} from "phoenix"

let socket = new Socket("/sensor_stream", {params: {}})

export default socket
