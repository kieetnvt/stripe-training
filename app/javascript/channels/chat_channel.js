import consumer from "channels/consumer"

consumer.subscriptions.create("ChatChannel", {
  connected() {
    console.log("Connected to the chat channel")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const messages = document.getElementById('messages')
    messages.innerHTML += `<p>${data.message}</p>`
  },

  speak(message) {
    console.log('speak', message)
    this.perform('speak', { message: message })
  }
});

document.addEventListener('DOMContentLoaded', () => {
  const input = document.getElementById('chat-input')
  input.addEventListener('keypress', (event) => {
    if (event.key === 'Enter') {
      const message = input.value
      input.value = ''
      console.log("consumer", consumer)
      consumer.subscriptions.subscriptions[0].speak(message)
    }
  })
});
