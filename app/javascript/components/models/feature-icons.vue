<template>
  <div class="flex md:-ml-2 xl:-ml-0">
    <div
      class="self-end w-8 h-8 p-2 mr-2 bg-gray-700 rounded-full lg:w-8 md:mr-1 xl:mr-2 lg:h-8 xl:w-9 xl:h-9 2xl:w-10 2xl:h-10 md:cursor-pointer"
      v-tooltip.bottom="tootipOtions(model, 'shiftOptions')"
    >
      <img
        src="../../../assets/images/icons/transmition-icon.svg"
        class="w-full h-full"
      >
    </div>
    <div
      class="self-end w-8 h-8 p-2 mr-2 bg-gray-700 rounded-full lg:w-8 md:mr-1 xl:mr-2 lg:h-8 xl:w-9 xl:h-9 2xl:w-10 2xl:h-10 md:cursor-pointer"
      v-tooltip.bottom="tootipOtions(model, 'tractionOptions')"
    >
      <img
        src="../../../assets/images/icons/traction-icon.svg"
        class="w-full h-full"
      >
    </div>
    <div
      class="self-end w-8 h-8 p-2 mr-2 bg-gray-700 rounded-full lg:w-8 md:mr-1 xl:mr-2 lg:h-8 xl:w-9 xl:h-9 2xl:w-10 2xl:h-10 md:cursor-pointer"
      v-tooltip.bottom="tootipOtions(model, 'fuelOptions')"
    >
      <img
        src="../../../assets/images/icons/fuel-icon.svg"
        class="w-full h-full"
      >
    </div>
  </div>
</template>
<script>
export default {
  props: {
    model: { type: Object, requier: true, default() { return {}; } },
  },
  data() {
    return {
      tooltipClassesOption: ['bg-gray-700 text-white text-xs font-main p-2 rounded-md mt-1'],
    };
  },
  methods: {
    tootipOtions(model, modelOptions) {
      return {
        content: model[modelOptions].map((option) => `<p>• ${option}</p>`).join(''),
        classes: this.tooltipClassesOption,
      };
    },
  },
};
</script>
<style>
.tooltip .tooltip-arrow {
  width: 0;
  height: 0;
  border-style: solid;
  position: absolute;
  margin: 5px;
  border-color: #374151;
  z-index: 1;
}

.tooltip[x-placement^="bottom"] .tooltip-arrow {
  border-width: 0 5px 5px;
  border-left-color: transparent !important;
  border-right-color: transparent !important;
  border-top-color: transparent !important;
  top: -5px;
  left: calc(50% - 5px);
  margin-top: 0;
  margin-bottom: 0;
}
</style>
