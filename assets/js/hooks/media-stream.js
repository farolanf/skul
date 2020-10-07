export default {
  videoSelect: {
    mounted() {
      navigator.mediaDevices.enumerateDevices()
        .then(devices => {
          devices.forEach(dev => {
            if (dev.kind === 'videoinput') {
              const optionEl = document.createElement('option')
              optionEl.value = dev.deviceId
              optionEl.innerText = dev.label
              this.el.appendChild(optionEl)
            }
          })
        })
    }
  },
  audioSelect: {
    mounted() {
      navigator.mediaDevices.enumerateDevices()
        .then(devices => {
          devices.forEach(dev => {
            if (dev.kind === 'audioinput') {
              const optionEl = document.createElement('option')
              optionEl.value = dev.deviceId
              optionEl.innerText = dev.label
              this.el.appendChild(optionEl)
            }
          })
        })
    }
  },
  mediaStream: {
    state: {
      videoDeviceId: null,
      audioDeviceId: null,
    },
    onVideoChange(videoDeviceId) {
      this.state.videoDeviceId = videoDeviceId
      this.start()
    },
    onAudioChange(audioDeviceId) {
      this.state.audioDeviceId = audioDeviceId
      this.start()
    },
    mounted() {
      window.mediaStream = this
      this.start()
    },
    start() {
      const videoEl = this.el.querySelector('video')

      const constraints = { 
        video: !this.state.videoDeviceId || {
          deviceId: this.state.videoDeviceId
        },
        audio: !this.state.audioDeviceId || {
          deviceId: this.state.audioDeviceId
        }
      }
      navigator.mediaDevices.getUserMedia(constraints)
        .then(mediaStream => {
          videoEl.srcObject = mediaStream
        })
      window.dispatchEvent(new CustomEvent('media-stream:start'))
    },
    stop() {
      const videoEl = this.el.querySelector('video')
      videoEl.srcObject = undefined
      window.dispatchEvent(new CustomEvent('media-stream:stop'))
    }
  }
}