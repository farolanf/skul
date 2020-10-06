import mediaStream from './media-stream'

const states = {
  state: {},
  actions: {}
}

const mergeState = (key, state) => {
  states.state[key] = state.state
  states.actions[key] = state.actions
}

mergeState('mediaStream', mediaStream)

export default states