<script setup lang="ts">
import {defineProps} from 'vue'
import UserType from "~/types/UserType";

const props = defineProps<{
  user: UserType
}>()

</script>

<template>
  <div>
    <p> {{ props.user.id }} </p>
  </div>
</template>

<style scoped>
</style>
