import React from 'react'
import globalHook from 'use-global-hook'
import states from './states'

const useGlobal = globalHook(React, states.state, states.actions)

export const useGlobalKey = key => {
  return useGlobal(state => state[key], actions => actions[key])
}

export default useGlobal