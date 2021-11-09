<template>
  <div class="md:col-span-4 lg:col-span-3">
    <div class="flex flex-col px-10 py-4 mb-4 border-2 border-gray-100 rounded-lg">
      <button
        class="focus:outline-none place-self-end"
        @click="$emit('set-show-filters')"
        v-if="$root.isMobile"
      >
        <img
          class="w-6 h-6"
          src="../../../assets/images/close.svg"
        >
      </button>
      <a class="mb-2">Rango de Precios</a>
      <div class="flex justify-between -mx-2 text-gray-400">
        <span>{{ formatToThousand(priceRange[0]) | currency('CLP') }} k</span>
        <span>{{ formatToThousand(priceRange[1]) | currency('CLP') }} k</span>
      </div>
      <vue-slider
        class="w-full mb-2"
        v-model="priceRange"
        :process-style="{ backgroundColor: '#20C6B6' }"
        :tooltip="'none'"
        :min="minRoundUpByInterval(priceOptions)"
        :max="maxPriceValue"
        :dot-size="18"
        :height="6"
        :interval="100"
        @change="emitFilteredModelList"
      />
      <a class="mb-2">Marca</a>
      <nexcar-multiselect
        v-model="selectedBrands"
        :options="brands"
        v-bind="commonMultiselectProps"
        label="name"
        track-by="id"
        @input="emitFilteredModelList"
      />
      <a class="mb-2">Modelo</a>
      <nexcar-multiselect
        v-model="selectedModels"
        :options="filterModels"
        v-bind="commonMultiselectProps"
        label="name"
        track-by="id"
        @input="emitFilteredModelList"
      />
      <a class="mb-2">Tipo de Vehículo</a>
      <nexcar-multiselect
        v-model="selectedCarTypeOptions"
        :options="carTypeOptions"
        v-bind="commonMultiselectProps"
        label="value"
        track-by="key"
        @input="emitFilteredModelList"
      />
      <a class="mb-2">Caja de Cambios</a>
      <nexcar-multiselect
        v-model="selectedShiftOptions"
        :options="shiftOptions"
        v-bind="commonMultiselectProps"
        label="value"
        track-by="key"
        @input="emitFilteredModelList"
      />
      <a class="mb-2">Tracción</a>
      <nexcar-multiselect
        v-model="selectedTractionOptions"
        :options="tractionOptions"
        v-bind="commonMultiselectProps"
        label="value"
        track-by="key"
        @input="emitFilteredModelList"
      />
      <a class="mb-2">Tipo de Combustible</a>
      <nexcar-multiselect
        v-model="selectedFuelOptions"
        :options="fuelOptions"
        v-bind="commonMultiselectProps"
        label="value"
        track-by="key"
        @input="emitFilteredModelList"
      />
    </div>
  </div>
</template>
<script>
import 'vue-slider-component/theme/default.css';
import VueSlider from 'vue-slider-component';
import { intersection, max, min, round } from 'lodash';

const INTERVAL = 100;
const THOUSANDS_SEPARATOR = 1000;

export default {
  components: { VueSlider },
  props: {
    carList: { type: Array, require: true, default() { return []; } },
    brands: { type: Array, require: true, default() { return []; } },
    models: { type: Array, require: true, default() { return []; } },
    shiftOptions: { type: Array, require: true, default() { return []; } },
    fuelOptions: { type: Array, require: true, default() { return []; } },
    tractionOptions: { type: Array, require: true, default() { return []; } },
    carTypeOptions: { type: Array, require: true, default() { return []; } },
    filterBrand: { type: Object, default() { return null; } },
  },
  data() {
    const priceOptions = this.models.reduce((allOptions, currentModel) =>
      [...allOptions, currentModel.minimumPrice], []);
    const selectedBrands = this.filterBrand ? [this.filterBrand] : [];

    return {
      priceRange: [this.minRoundUpByInterval(priceOptions), this.maxRoundUpByInterval(priceOptions)],
      priceOptions,
      selectedModels: [],
      selectedBrands,
      selectedShiftOptions: [],
      selectedFuelOptions: [],
      selectedTractionOptions: [],
      selectedCarTypeOptions: [],
    };
  },
  computed: {
    filterModels() {
      return this.arrayFilteredBy(this.models, 'brandName', this.selectedBrands, 'name');
    },
    maxPriceValue() {
      return this.maxRoundUpByInterval(this.priceOptions);
    },
    commonMultiselectProps() {
      return {
        multiple: true,
        closeOnSelect: false,
        clearOnSelect: false,
        preserveSearch: true,
        searchable: true,
        placeholder: '',
      };
    },
  },
  beforeMount() {
    if (this.filterBrand) this.emitFilteredModelList();
  },
  methods: {
    formatToThousand(number) {
      return round(number / THOUSANDS_SEPARATOR);
    },
    maxRoundUpByInterval(arrayOptions) {
      let maxOption = max(arrayOptions);
      const rest = maxOption % INTERVAL;
      if (rest !== 0) maxOption = maxOption + INTERVAL - rest;

      return maxOption;
    },
    minRoundUpByInterval(arrayOptions) {
      let minOption = min(arrayOptions);
      const rest = minOption % INTERVAL;
      if (rest !== 0) minOption = minOption + INTERVAL - rest;

      return minOption;
    },
    arrayFilteredBy(array, arrayAttribute, options, optionsAttribute = null) {
      let shadowOptions = options;
      if (optionsAttribute) shadowOptions = options.map((object) => object[optionsAttribute]);
      if (shadowOptions.length > 0) {
        return array.filter((object) => {
          if (Array.isArray(object[arrayAttribute])) {
            return intersection(shadowOptions, object[arrayAttribute]).length > 0;
          }

          return shadowOptions.includes(object[arrayAttribute]);
        });
      }

      return array;
    },
    modelFilterByPriceRange(models) {
      const priceRange = this.priceRange;

      return models.filter((model) =>
        (priceRange[0] <= model.minimumPrice && model.minimumPrice <= priceRange[1]));
    },
    emitFilteredModelList() {
      let filterModels = this.models;
      filterModels = this.modelFilterByPriceRange(filterModels);
      filterModels = this.arrayFilteredBy(filterModels, 'brandName', this.selectedBrands, 'name');
      filterModels = this.arrayFilteredBy(filterModels, 'name', this.selectedModels, 'name');
      filterModels = this.arrayFilteredBy(filterModels, 'carType',
        this.selectedCarTypeOptions, 'value');
      filterModels = this.arrayFilteredBy(filterModels, 'shiftOptions', this.selectedShiftOptions,
        'value');
      filterModels = this.arrayFilteredBy(filterModels, 'tractionOptions',
        this.selectedTractionOptions, 'value');
      filterModels = this.arrayFilteredBy(filterModels, 'fuelOptions', this.selectedFuelOptions,
        'value');

      this.$emit('set-filter-models', filterModels);
    },
  },
};
</script>
