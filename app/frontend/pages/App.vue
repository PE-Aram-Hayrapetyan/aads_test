<script setup lang="ts">
import { defineProps } from 'vue'

const props = defineProps<{
  user: object
}>()
</script>

<template>
  <div>
    <p> {{props.user.id}} </p>
  </div>
</template>

<style scoped>
</style>
