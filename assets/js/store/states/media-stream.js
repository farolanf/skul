export default {
  state: {
    videoDeviceId: undefined,
    audioDeviceId: undefined
  },
  actions: {
    setVideoDevice: (store, videoDeviceId) => {
      store.setState({ 
        mediaStream: {
          ...store.state.mediaStream,
          videoDeviceId
        }
      })
    },
    setAudioDevice: (store, audioDeviceId) => {
      store.setState({ 
        mediaStream: {
          ...store.state.mediaStream,
          audioDeviceId 
        }
      })
    }
  }
}