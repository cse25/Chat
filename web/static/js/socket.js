import {Socket} from "phoenix"
let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

const createSocket = (roomId) => {
  let channel = socket.channel(`messages:${roomId}`, {})
  channel
    .join()
    .receive("ok", resp => {
      console.log(resp)
      renderMessages(resp.messages)
    })
    .receive("error", resp => {
      console.log("Unable to join", resp)
    })

  channel.on(`messages:${roomId}:new`, renderMessage)

  document.querySelector('button').addEventListener('click', () => {
    const message = document.querySelector('textarea').value

    channel.push('message:add', { message: message })
  })
}

function renderMessages(messages) {
  const renderedMessages = messages.map(message => {
    return messageTemplate(message)
  })

  document.querySelector('.collection').innerHTML = renderedMessages.join('')
}

function renderMessage(event) {
  const renderedMessage = messageTemplate(event.message)

  document.querySelector('.collection').innerHTML += renderedMessage
}

function messageTemplate(message) {
  let personaname = 'Anonymous'
  if (message.user) {
    personaname = message.user.personaname
  }

  return `
    <li class="collection-item">
      ${message.message}
      <div class="secondary-content">
        ${personaname}
      </div>
    </li>
  `
}

window.createSocket = createSocket
