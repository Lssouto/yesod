<template>
    <section id="index">
       <calendar />
       <notes />
    </section>
</template>

<script>
import Calendar from './Index-calendar'
import Notes from './Index-notes'
export default {
    name: "Homepage",
	components: {
	    Calendar,
	    Notes
	}
}
</script>

<style lang="scss">
</style>