<template>
  <div class="flex h-auto mb-2 md:col-span-4 md:mb-7">
    <div class="w-3 mr-2 bg-nexcar-green" />
    <div class="flex flex-col w-3/5 md:justify-start">
      <p class="col-span-1 text-xl xl:text-2xl text-nexcar-black">
        {{ model.brandName }}
      </p>
      <p class="col-span-1 text-2xl font-medium xl:text-4xl text-nexcar-black">
        {{ model.name }}
      </p>
    </div>
    <feature-icons
      class="justify-end w-2/5"
      :model="model"
    />
  </div>
</template>
<script>
import FeatureIcons from './feature-icons.vue';

export default {
  components: {
    FeatureIcons,
  },
  props: {
    model: { type: Object, default() { return {}; } },
  },
};
</script>
