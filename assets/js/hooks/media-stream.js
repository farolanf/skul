import React, { useState, useEffect } from 'react'
import ReactDOM from 'react-dom'
import { useGlobalKey } from '../store'

const DeviceSelect = ({ devices, value, onChange }) => (
  devices.length > 0 && (
    <select onChange={e => onChange(e.target.value)} value={value}>
      {devices.map(dev => (
        <option key={dev.deviceId} value={dev.deviceId}>{dev.label}</option>
      ))}
    </select> 
  )
)

const MediaSelect = ({ phx }) => {
  const [state, actions] = useGlobalKey('mediaStream')
  const [videoInputs, setVideoInputs] = useState([])
  const [audioInputs, setAudioInputs] = useState([])

  useEffect(() => {
    navigator.mediaDevices.enumerateDevices()
      .then(devices => {
        setVideoInputs(devices.filter(dev => dev.kind === 'videoinput'))
        setAudioInputs(devices.filter(dev => dev.kind === 'audioinput'))
      })
  }, [])

  const testEvent = () => {
    phx.pushEvent('test-event', { name: 'test' }, reply => {
      console.log('reply', reply)
    })
  }

  return (
    <div>
      <button onClick={testEvent}>test event</button>
      <label>
        Video
        <DeviceSelect devices={videoInputs} value={state.videoDeviceId} onChange={actions.setVideoDevice} />
      </label>
      <label>
        Audio
        <DeviceSelect devices={audioInputs} value={state.audioDeviceId} onChange={actions.setAudioDevice} />
      </label>
    </div>
  )
}

export default {
  mediaStream: {
    mounted() {
      const videoEl = this.el.querySelector('video')

      const constraints = { audio: true, video: true }
      navigator.mediaDevices.getUserMedia(constraints)
        .then(mediaStream => {
          videoEl.srcObject = mediaStream
        })
    }
  },
  MediaSelect: {
    mounted() {
      ReactDOM.render(<MediaSelect phx={this} />, this.el)
    },
    updated() {
      ReactDOM.render(<MediaSelect phx={this} />, this.el)
    },
    beforeUpdate() {
      ReactDOM.unmountComponentAtNode(this.el)
    }
  }
}