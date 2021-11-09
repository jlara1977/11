<template>
  <div
    class="grid md:grid-cols-12 gap-x-9 md:gap-y-7"
  >
    <div class="mx-2 mb-4 md:col-span-12">
      <a
        class="flex items-center w-1/5"
        href="/cars"
      >
        <img
          src="../../../assets/images/back-icon.svg"
          class="mr-4"
        >
        <p v-if="!this.$root.isMobile">
          Volver a la búsqueda
        </p>
      </a>
    </div>
    <div
      class="flex row-start-3 mb-4 md:flex-col md:row-span-3 md:row-start-2 md:col-span-8 md:mb-0"
    >
      <img
        :src="mainImageUrl"
        class="self-center object-scale-down w-4/5 mr-2 rounded-sm md:w-full md:mb-4 md:mr-0 main-model-image h-44"
      >
      <div
        class="flex flex-col items-center justify-between w-1/5 md:w-auto md:flex-row md:col-span-8"
        v-if="imagesPresent"
      >
        <img
          src="../../../assets/images/icons/previous-arrow-icon.svg"
          class="w-10 h-10 p-2 rounded-full"
          :class="{ 'hover:bg-nexcar-second-light-green cursor-pointer': this.imagesOffset > 0,
                    'rotate-90 transform': this.$root.isMobile }"
          @click="updateImagesOffset(-1)"
        >
        <img
          v-for="(image) in restImages"
          :key="image.id"
          :src="image.imageUrl"
          class="object-scale-down h-8 mb-0.5 cursor-pointer md:mb-4 md:h-24 rounded-sm border border-white hover:border-nexcar-green"
          @click="changeBigImageStatus(image.id)"
        >
        <img
          src="../../../assets/images/icons/next-arrow-icon.svg"
          class="w-10 h-10 p-2 rounded-full"
          :class="{ 'hover:bg-nexcar-second-light-green cursor-pointer':
                      this.imagesOffset + 1 + this.numberOfImages <= this.notSelectedImages.length,
                    'rotate-90 transform': this.$root.isMobile }"
          @click="updateImagesOffset(1)"
        >
      </div>
      <div
        v-else-if="!this.$root.isMobile"
        class="md:col-span-8"
      />
      <span
        v-if="!this.$root.isMobile"
        class="text-sm"
      >
        *Imágenes referenciales
      </span>
    </div>
    <title-component
      :model="model"
      v-if="this.$root.isMobile"
    />
    <span
      v-if="this.$root.isMobile"
      class="mb-2 mr-2 text-xxs justify-self-end md:text-base grid-span-2"
    >
      *Imágenes referenciales
    </span>
    <div
      class="px-5 py-4 mb-4 rounded-lg shadow md:col-span-4 md:row-span-2 bg-nexcar-green-200"
      :class="{'mx-4': this.$root.isMobile}"
    >
      <title-component
        :model="model"
        v-if="!this.$root.isMobile"
      />
      <a class="mb-4 text-xl">Versión</a>
      <nexcar-multiselect
        class="w-full col-span-2 mb-4"
        v-model="selectedCarVersionOption"
        :options="carVersions"
        v-bind="commonMultiselectProps"
        track-by="id"
        label="name"
      />
      <a class="mb-4 text-xl">Kilometraje Anual</a>
      <nexcar-multiselect
        class="w-full col-span-2 mb-4"
        v-model="selectedAnnualDistanceOption"
        :options="annualDistanceOptions"
        v-bind="commonMultiselectProps"
      />
      <p class="mb-4 text-xl">
        Planes de Suscripción
      </p>
      <div
        class="mb-4 text-left"
      >
        <div
          class="flex items-center justify-around w-full px-3 py-2 bg-white border-l border-r border-gray-300 cursor-pointer last:mb-1"
          :class="{ 'bg-nexcar-second-light-green border border-nexcar-green':
                      priceVersion.id === selectedPriceVersion.id,
                    'border-t rounded-t-lg': index === 0,
                    'rounded-b-lg border-b': index === filteredPriceVersions.length - 1 }"
          v-for="(priceVersion, index) in filteredPriceVersions"
          :value="priceVersion"
          :key="index"
          @click="changePriceVersion(priceVersion)"
        >
          <div
            class="flex items-center justify-center w-5 h-5 mr-2 bg-white border border-gray-400 rounded-sm"
            :class="{ 'border-nexcar-dark-green': priceVersion.id === selectedPriceVersion.id }"
          >
            <div
              class="w-3 h-3 rounded-sm"
              :class="{ 'bg-nexcar-dark-green': priceVersion.id === selectedPriceVersion.id }"
            />
          </div>
          <p class="md:text-sm xl:text-base">
            {{ priceVersion.formattedMonthlyPrice }} mensuales
          </p>
          <p class="md:text-sm xl:text-base">
            {{ priceVersion.contractTime }} meses
          </p>
        </div>
        <p class="px-3 text-xs text-right text-gray-700 md:text-xxs xl:text-xs">
          IVA incluido.
          Calculados con la UF del 1 del mes.<br>
          Sujeto a disponibilidad de stock.<br>
          Precios válidos por {{ this.selectedCarVersionOption.formattedLastValidDatePrices }}
        </p>
      </div>
      <div class="flex justify-center mb-4 md:mx-4 md:col-span-4">
        <button
          class="w-1/2 p-2 text-white rounded-lg bg-nexcar-green hover:bg-nexcar-dark-green focus:outline-none"
          @click="showConfirmationModal()"
        >
          Reservar
        </button>
      </div>
    </div>
    <div class="p-3 text-center border rounded-md md:p-4 mb-7 md:mb-9 lg:rounded-lg md:col-span-12 md:text-lg">
      <p class="font-medium">
        ¿Te gustaría disminuir tu cuota mensual?
      </p>
      <p class="md:text-lg">
        Conoce nuestra opción de anticipo inicial y cofinanciamiento
        <span
          class="font-medium cursor-pointer text-nexcar-green"
          @click="showCostReduceModal()"
        >
          aquí
        </span>
      </p>
    </div>
    <div
      class="flex flex-col mx-4 mb-4 md:col-span-12 text-nexcar-black"
    >
      <div class="flex col-span-3 md:col-span-12">
        <div
          class="mr-4 cursor-pointer"
          @click="changeDetailsSelected"
        >
          <p
            class="text-lg md:text-2xl"
          >
            Detalles
          </p>
          <div
            class="w-24 h-1 bg-gray-400"
            :class="{ 'bg-nexcar-green': this.detailsSelected }"
          />
        </div>
        <div
          class="cursor-pointer"
          @click="changeDetailsSelected"
        >
          <p
            class="text-lg md:text-2xl"
          >
            Ficha técnica
          </p>
          <div
            class="h-1 bg-gray-400 w-30"
            :class="{ 'bg-nexcar-green': !this.detailsSelected }"
          />
        </div>
      </div>
      <div class="w-full mb-4 border-b border-gray-300" />
      <div
        class="grid grid-cols-3 md:grid-cols-12"
        v-if="this.detailsSelected"
      >
        <div class="justify-self-center md:justify-self-end">
          <img
            src="../../../assets/images/icons/confort-icon.svg"
            class="w-11 h-11 md:w-16 md:h-16"
          >
        </div>
        <div class="flex flex-col col-span-2 md:justify-self-center md:col-span-3">
          <p class="mb-4 text-lg md:mb-8 text-nexcar-green md:text-2xl">
            Confort
          </p>
          <p class="mb-2 text-sm md:text-base">
            {{ selectedCarVersionOption.fuel }}
          </p>
          <p class="mb-2 text-sm md:text-base">
            {{ selectedCarVersionOption.shift }}
          </p>
          <p class="mb-2 text-sm md:text-base">
            {{ selectedCarVersionOption.traction }}
          </p>
          <p class="mb-2 text-sm md:text-base">
            {{ selectedCarVersionOption.rowSeats }} corridas de asientos
          </p>
          <p
            class="mb-2 text-sm md:text-base last:mb-4"
            v-for="characteristic in comfortCharacteristics"
            :key="characteristic.id"
          >
            {{ capitalize(characteristic.name) }}
          </p>
        </div>
        <div class="justify-self-center md:justify-self-end">
          <img
            src="../../../assets/images/icons/multimedia-icon.svg"
            class="w-11 h-11 md:w-16 md:h-16"
          >
        </div>
        <div class="flex flex-col col-span-2 md:justify-self-center md:col-span-3">
          <p class="mb-4 text-lg md:mb-8 text-nexcar-green md:text-2xl">
            Multimedia
          </p>
          <p
            class="mb-2 text-sm md:text-base last:mb-4"
            v-for="characteristic in multimediaCharacteristics"
            :key="characteristic.id"
          >
            {{ capitalize(characteristic.name) }}
          </p>
        </div>
        <div class="justify-self-center md:justify-self-end">
          <img
            src="../../../assets/images/icons/security-icon.svg"
            class="w-11 h-11 md:w-16 md:h-16"
          >
        </div>
        <div class="flex flex-col col-span-2 md:justify-self-center md:col-span-3">
          <p class="mb-4 text-lg md:mb-8 text-nexcar-green md:text-2xl">
            Seguridad
          </p>
          <p class="mb-2 text-sm md:text-base">
            {{ selectedCarVersionOption.airbags }} airbags
          </p>
          <p
            class="mb-2 text-sm md:text-base"
            v-for="characteristic in securityCharacteristics"
            :key="characteristic.id"
          >
            {{ capitalize(characteristic.name) }}
          </p>
        </div>
      </div>
      <div
        v-else
        class="mb-20 text-sm text-gray-700 md:text-base md:mb-40"
      >
        <div v-if="this.model.technicalFile">
          Revisa los detalles del modelo aquí:
          <a
            :href="this.model.technicalFile.documentUrl"
            target="_blank"
            class="underline text-nexcar-green"
          >
            descargar
          </a>
        </div>
        <p v-else>
          No hay ficha disponible
        </p>
      </div>
    </div>
  </div>
</template>
<script>
import { uniq, unionBy } from 'lodash';
import ReservationRequestModal from './reservation-request-modal';
import CostReduceModal from './cost-reduce-modal';
import TitleComponent from './title-component.vue';

const MAX_IMAGES_SHOWN_XL = 4;
const MAX_IMAGES_SHOWN_LG = 3;
const MAX_IMAGES_SHOWN_MD = 2;
const MAX_IMAGES_SHOWN_MOBILE = 4;

export default {
  components: {
    TitleComponent,
  },
  props: {
    model: { type: Object, require: true, default() { return {}; } },
    carVersions: { type: Array, require: true, default() { return []; } },
    typeOfClients: { type: Array, require: true, default() { return []; } },
  },
  data() {
    const initialCarVersion = this.carVersions[0];
    const initialPriceVersion = initialCarVersion.priceVersions[0];

    return {
      selectedCarVersionOption: initialCarVersion,
      selectedPriceVersion: initialPriceVersion,
      selectedAnnualDistanceOption: initialPriceVersion.annualDistance,
      selectedContractTimeOption: initialPriceVersion.contractTime,
      carVesions: this.carVersions,
      mainImage: this.model.images.length > 0 ? this.findMainImage() : this.model,
      images: this.model.images,
      detailsSelected: true,
      imagesOffset: 0,
    };
  },
  computed: {
    imagesPresent() {
      return this.model.images.length > 0;
    },
    mainImageUrl() {
      return this.mainImage.imageUrl;
    },
    numberOfImages() {
      if (this.$root.isMobile) {
        return MAX_IMAGES_SHOWN_MOBILE;
      } else if (this.$root.isMedium) {
        return MAX_IMAGES_SHOWN_MD;
      } else if (this.$root.isLarge) {
        return MAX_IMAGES_SHOWN_LG;
      }

      return MAX_IMAGES_SHOWN_XL;
    },
    notSelectedImages() {
      return this.images.filter((image) => image.id !== this.mainImage.id);
    },
    restImages() {
      return this.notSelectedImages.slice(this.imagesOffset, this.imagesOffset + this.numberOfImages);
    },
    priceVersions() {
      return this.selectedCarVersionOption.priceVersions;
    },
    filteredPriceVersions() {
      let filteredPriceVersions = this.priceVersions;
      if (this.selectedAnnualDistanceOption) {
        filteredPriceVersions = this.priceVersions.filter((priceVersion) =>
          priceVersion.annualDistance === this.selectedAnnualDistanceOption);
      }

      return filteredPriceVersions;
    },
    annualDistanceOptions() {
      return uniq(this.priceVersions.map((priceVersion) => priceVersion.annualDistance));
    },
    commonMultiselectProps() {
      return {
        multiple: false,
        closeOnSelect: true,
        clearOnSelect: false,
        preserveSearch: true,
        allowEmpty: false,
        searchable: true,
        placeholder: '',
      };
    },
    comfortCharacteristics() {
      return unionBy(this.model.comfortCharacteristics,
        this.selectedCarVersionOption.comfortCharacteristics, 'id');
    },
    multimediaCharacteristics() {
      return unionBy(this.model.multimediaCharacteristics,
        this.selectedCarVersionOption.multimediaCharacteristics, 'id');
    },
    securityCharacteristics() {
      return unionBy(this.model.securityCharacteristics,
        this.selectedCarVersionOption.securityCharacteristics, 'id');
    },
  },
  methods: {
    updateImagesOffset(updateValue) {
      if (this.imagesOffset + updateValue < 0 ||
        this.imagesOffset + updateValue + this.numberOfImages > this.notSelectedImages.length) {
        this.imagesOffset = 0;
      } else {
        this.imagesOffset += updateValue;
      }
    },
    findMainImage() {
      const mainModelImage = this.model.images.filter(image => image.mainModelImage);
      if (mainModelImage.length > 0) return mainModelImage[0];

      return this.model.images[0];
    },
    changeBigImageStatus(imageId) {
      const selectedImage = this.images.find((image) => image.id === imageId);
      this.mainImage = selectedImage;
    },
    changePriceVersion(priceVersion) {
      this.selectedPriceVersion = priceVersion;
    },
    showConfirmationModal() {
      this.$modal.show(ReservationRequestModal, {
        model: this.model,
        carVersion: this.selectedCarVersionOption,
        priceVersion: this.selectedPriceVersion,
        annualDistance: this.selectedAnnualDistanceOption,
        contractTime: this.selectedPriceVersion.contractTime,
        typeOfClients: this.typeOfClients,
      }, {
        width: '100%',
        maxWidth: this.$root.mdScreen,
        height: 'auto',
        adaptive: true,
        scrollable: true,
        name: 'reservation-request-modal',
      });
    },
    showCostReduceModal() {
      this.$modal.show(CostReduceModal, {}, {
        width: '100%',
        maxWidth: this.$root.mdScreen,
        height: 'auto',
        adaptive: true,
        scrollable: true,
        name: 'cost-reduce-modal',
      });
    },
    capitalize(string) {
      return string.charAt(0).toUpperCase() + string.slice(1);
    },
    changeDetailsSelected() {
      this.detailsSelected = !this.detailsSelected;
    },
  },
  watch: {
    selectedCarVersionOption() {
      if (this.selectedCarVersionOption.annualDistances.includes(this.selectedAnnualDistanceOption)) {
        const filterPriceVersions = this.selectedCarVersionOption.priceVersions.filter((carVersion) =>
          carVersion.annualDistance === this.selectedAnnualDistanceOption);
        this.selectedPriceVersion = filterPriceVersions[0];
      } else {
        this.selectedPriceVersion = this.selectedCarVersionOption.priceVersions[0];
        this.selectedAnnualDistanceOption = this.selectedPriceVersion.annualDistance;
      }
    },
    selectedAnnualDistanceOption() {
      this.selectedPriceVersion = this.filteredPriceVersions[0];
    },
  },
};
</script>
<style lang="scss">
.main-model-image {
  @media (min-width: 768px) {
    height: 482px;
  }
}
</style>
