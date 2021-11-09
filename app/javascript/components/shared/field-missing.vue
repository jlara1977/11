<template>
  <p
    class="text-sm text-red-500"
  >
    {{ this.fillMessage }}
  </p>
</template>
<script>
export default {
  props: { fillMessage: { type: String, default() { return 'Falta completar este campo'; } } },
};
</script>
