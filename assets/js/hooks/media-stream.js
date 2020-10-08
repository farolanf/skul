require('../vendors/openvidu-browser-2.15.0')

export default {
  openvidu: {
    mounted() {
      window.mediaStream = this
      window.addEventListener('beforeunload', () => this.openviduDestroy())

      const openvidu = new OpenVidu()

      const session = this.session = openvidu.initSession()

      session.on('streamCreated', event => {
        session.subscribe(event.stream, 'other-streams')
      })

      this.handleEvent("openvidu_token", async ({ token }) => {
        await session.connect(token, { clientData: window.currentUser.username })
        const publisher = openvidu.initPublisher('my-stream', {
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
    },
    openviduDestroy() {
      if (!this.session) return
      this.session.disconnect()
      this.session = null
    },
    beforeDestroy() {
      this.openviduDestroy()
    },
  }
}