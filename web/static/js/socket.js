import {Socket} from "phoenix"
let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

const createSocket = (roomId) => {
  let channel = socket.channel(`messages:${roomId}`, {})
    channel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp) })
    .receive("error", resp => { console.log("Unable to join", resp) })

  document.querySelector('button').addEventListener('click', () => {
    const message = document.querySelector('textarea').value

    channel.push('message:add', { message: message })
  })
}

window.createSocket = createSocket
