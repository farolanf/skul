require('../../vendor/openvidu-browser-2.15.0')

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
        this.publisher = openvidu.initPublisher('main-stream', {
          audioSource: undefined,
          videoSource: undefined,
          publishAudio: true,
          publishVideo: true,
          resolution: '640x480',
          frameRate: 30,
          insertMode: 'APPEND',
          mirror: false
        })
        this.startLocalStream()
      })
    },
    startLocalStream() {
      if (!this.publisher) {
        this.pushEvent('get_token')
        return 
      }
      this.session.publish(this.publisher)
      window.dispatchEvent(new CustomEvent('main-stream:started'))
    },
    stopLocalStream() {
      this.session.unpublish(this.publisher)
      window.dispatchEvent(new CustomEvent('main-stream:stopped'))
    },
    openviduDestroy() {
      if (!this.session) return
      this.session.disconnect()
      this.session = null
      window.dispatchEvent(new CustomEvent('main-stream:stopped'))
    },
    beforeDestroy() {
      this.openviduDestroy()
    },
  }
}