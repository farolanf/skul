require('./openvidu-browser-2.15.0')

export default {
  autofocus: {
    mounted() {
      this.el.focus()
    }
  },
  openviduSession: {
    mounted() {
      const openVidu = new OpenVidu()
      
      const session = openVidu.initSession()

      session.on('streamCreated', event => {
        session.subscribe(event.stream, 'other-streams')
      })

      this.handleEvent("openvidu_token", async ({ token }) => {
        console.log("openvidu_token", token)
        await session.connect(token, { clientData: "skuluser1" })
        const publisher = openVidu.initPublisher('my-stream', {
          audioSource: undefined,
          videoSource: undefined,
          publishAudio: true,
          publishVideo: true,
          resolution: '640x480',
          frameRate: 30,
          insertMode: 'APPEND',
          mirror: false
        })
        session.publish(publisher)
      })
    }
  }
}