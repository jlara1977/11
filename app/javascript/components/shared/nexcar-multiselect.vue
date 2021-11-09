<template>
  <multiselect
    class="w-full mb-4"
    select-label=""
    selected-label=""
    deselect-label="Sacar"
    :value="value"
    :options="options"
    v-bind="$attrs"
    :label="label"
    :track-by="trackBy"
    @input="(newValue) => this.$emit('input', newValue)"
  />
</template>
<script>
export default {
  props: {
    value: { type: [Array, Object, String], default() { return {}; } },
    options: { type: Array, default() { return []; } },
    label: { type: String, default: null },
    trackBy: { type: String, default: null },
  },
};
</script>
<style lang="scss">
.multiselect {
  &__tag {
    @apply bg-nexcar-green;
  }

  &__option--highlight,
  &__option--highlight::after {
    @apply bg-nexcar-green text-white #{!important};
  }

  &__option--selected,
  &__option--selected::after {
    @apply bg-nexcar-dark-green text-white #{!important};
  }
}
</style>
