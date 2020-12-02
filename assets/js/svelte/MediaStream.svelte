<script>
  export let name = '';

  function handleClick() {
    name = 'girl!'
    console.log('handleClick')
  }
</script>

<h1 on:click={handleClick}>Media Stream Svelte! {name}</h1>
<button on:click={handleClick}>Test Handler</button>