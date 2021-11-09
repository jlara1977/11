<template>
  <div
    class="grid grid-cols-1 md:grid-cols-2 gap-y-2 md:gap-x-8"
    :class="{ 'mx-6': this.$root.isMobile }"
  >
    <div class="flex flex-col justify-center w-full text-gray-700 md:px-8">
      <h1 class="mb-6 text-xl font-medium md:text-3xl md:mb-11">
        Tu auto en <span class="font-semibold text-nexcar-green">una sola<br> cuota mensual</span>
      </h1>
      <p class="mb-6 text-xs md:text-base md:mb-11">
        Maneja el auto de tus sueños con todo incluido. <br v-if="!this.$root.isMobile">
        Mantenciones, impuestos, seguros, patente
        <span class="font-medium text-nexcar-green">y mucho <br v-if="!this.$root.isMobile">
          más</span> a cambio de una suscripción!
      </p>
      <a
        class="flex items-center justify-center w-40 px-2 py-1 text-base text-center text-white rounded-md md:px-9 md:py-2 md:w-60 mb-14 md:h-14 justify-self-center bg-nexcar-green md:text-lg lg:text-xl hover:bg-nexcar-dark-green"
        href="/cars"
      >
        Busca tu Nexcar
      </a>
    </div>
    <img
      v-if="this.$root.isMobile"
      src="../../../assets/images/one-quote-landing-with-car-mobile.svg"
      class="object-scale-down -mt-16"
    >
    <img
      v-else
      src="../../../assets/images/one-quote-landing-with-car.svg"
      class="max-w-xl"
    >
    <div class="px-8 py-8 mb-10 -mx-6 text-gray-700 bg-gray-100 md:mb-20 md:col-span-2 md:-mx-0">
      <p class="text-xl font-medium md:texl-3xl mb-9">
        ¿Por qué suscribirse?
      </p>
      <div class="flex flex-col mb-4 lg:flex-row">
        <div class="flex p-4 mb-5 bg-white border rounded-md shadow-md lg:mr-10 lg:mb-0">
          <img
            src="../../../assets/images/icons/simple-icon.svg"
            class="mr-4 w-7 h-7"
          >
          <div class="flex flex-col">
            <p class="mb-4 text-lg font-medium lg:text-xl">
              Simple
            </p>
            <p class="text-sm text-gray-500">
              Tú solo te encargas de la bencina y el TAG. Nosotros nos encargamos del resto.
            </p>
          </div>
        </div>
        <div class="flex p-4 mb-5 bg-white border rounded-md shadow-md lg:mr-10 lg:mb-0">
          <img
            src="../../../assets/images/icons/flexible-icon.svg"
            class="mr-4 w-9 h-7"
          >
          <div class="flex flex-col">
            <p class="mb-4 text-lg font-medium lg:text-xl">
              Flexible
            </p>
            <p class="text-sm text-gray-500">
              Planes a tu medida con plazos de 12, 24, 36 y 48 meses, y kilometraje anual que elijas.
            </p>
          </div>
        </div>
        <div class="flex p-4 bg-white border rounded-md shadow-md lg:mb-0">
          <img
            src="../../../assets/images/icons/convenient-icon.svg"
            class="w-8 h-8 mr-4"
          >
          <div class="flex flex-col">
            <p class="mb-4 text-lg font-medium lg:text-xl">
              Conveniente
            </p>
            <p class="text-sm text-gray-500">
              Es la forma más económica de tener tu auto 0 Km. Si aún tienes dudas, escríbenos.
            </p>
          </div>
        </div>
      </div>
    </div>
    <h2 class="mb-5 text-xl font-medium text-gray-700 md:col-span-2 justify-self-center md:text-2xl lg:text-3xl">
      Busca por tu marca favorita
    </h2>
    <div class="flex flex-wrap justify-center mb-9 md:mb-16 md:col-span-2">
      <div
        v-for="(brand, index) in brands"
        :key="brand.id"
        class="flex md:mr-4 last:mr-0"
      >
        <img
          :src="brand.imageUrl"
          class="object-scale-down w-20 h-20 p-2 cursor-pointer md:mr-4 md:w-24 md:h-20 last:mr-0"
          @click="getCarsFiltered(brand)"
        >
        <div
          class="w-0.5 h-full bg-gray-200"
          v-if="!$root.isMobile && index != brands.length - 1"
        />
      </div>
    </div>
    <div class="md:col-span-2 h-0.5 border-gray-200 border-b md:border-b-2 md:w-3/5 w-4/5 justify-self-center mb-10 md:mb-20" />
    <div class="flex flex-col items-center mb-10 text-gray-700 md:col-span-2 md:mb-20">
      <h2 class="mb-6 text-xl font-medium text-center md:text-2xl lg:text-3xl md:mb-9">
        Súbete a tu nexcar en <span class="font-semibold text-nexcar-green">3</span> simples pasos
      </h2>
      <div class="flex flex-col items-center w-full mb-4 md:flex-row md:justify-around md:mb-10">
        <div class="flex flex-col items-center max-w-xs p-3 mb-6 text-center border rounded-md shadow-md md:w-96 md:h-96 lg:w-auto md:py-5 md:mb-0">
          <p class="mb-5 text-xl md:text-2xl md:mb-9">
            Paso <span class="text-nexcar-green">1</span>
          </p>
          <img
            src="../../../assets/images/icons/first-step-icon.svg"
            class="w-10 h-12 mb-5 md:w-16 md:h-20 md:mb-9"
          >
          <p class="mb-5 font-semibold md:text-lg md:mb-7">
            Elige el auto y el plan
          </p>
          <p class="text-sm md:text-base md:mb-5">
            Selecciona el auto y plan que más te acomode y reserva online
          </p>
        </div>
        <img
          src="../../../assets/images/icons/next-step-arrow-icon.svg"
          class="mb-6 w-7 h-7 md:mb-0"
          :class="{ 'rotate-90 transition-transform duration-500 transform': this.$root.isMobile }"
        >
        <div class="flex flex-col items-center max-w-xs p-3 mb-6 text-center border rounded-md shadow-md md:h-96 md:w-96 lg:w-auto md:py-5 md:mb-0">
          <p class="mb-5 text-xl md:text-2xl md:mb-9">
            Paso <span class="text-nexcar-green">2</span>
          </p>
          <img
            src="../../../assets/images/icons/second-step-icon.svg"
            class="w-10 h-12 mb-5 md:w-16 md:h-20 md:mb-9"
          >
          <p class="mb-5 font-semibold md:text-lg md:mb-2">
            Envíanos la documentación solicitada
          </p>
          <p class="text-sm md:text-base md:mb-5">
            Te pediremos ciertos documentos para una evaluación comercial
          </p>
        </div>
        <img
          src="../../../assets/images/icons/next-step-arrow-icon.svg"
          class="mb-6 w-7 h-7 md:mb-0"
          :class="{ 'rotate-90 transition-transform duration-500 transform': this.$root.isMobile }"
        >
        <div class="flex flex-col items-center max-w-xs p-3 mb-6 text-center border rounded-md shadow-md md:h-96 md:py-5 md:w-96 lg:w-auto md:mb-0">
          <p class="mb-5 text-xl md:text-2xl md:mb-9">
            Paso <span class="text-nexcar-green">3</span>
          </p>
          <img
            src="../../../assets/images/icons/third-step-icon.svg"
            class="w-10 h-12 mb-5 md:w-16 md:h-20 md:mb-9"
          >
          <p class="mb-5 font-semibold md:text-lg md:mb-7">
            Entrega del auto
          </p>
          <p class="text-sm md:text-base md:mb-5">
            Te entregaremos tu auto donde tú quieras
          </p>
        </div>
      </div>
      <p class="mb-3 text-lg md:text-xl lg:text-2xl">
        ¡Así de fácil!
      </p>
      <a
        class="flex items-center justify-center w-40 h-8 p-1 text-base text-white align-text-bottom rounded-md md:w-48 md:h-10 lg:w-60 md:p-2 lg:h-12 bg-nexcar-green md:text-xl hover:bg-nexcar-dark-green"
        href="/cars"
      >
        Busca tu Nexcar
      </a>
    </div>
    <div class="md:col-span-2 h-0.5 border-gray-200 border-b md:border-b-2 w-4/5 md:w-3/5 justify-self-center mb-10 md:mb-20" />
    <price-comparison-grid class="mb-10 md:col-span-2 md:mb-14 lg:mb-16" />
    <div class="flex flex-col items-center px-4 mb-10 -mx-6 text-gray-700 bg-gray-100 md:pt-20 md:pb-12 xl:px-40 md:col-span-2 lg:flex-row md:mb-20 py-7">
      <div class="flex flex-col mb-7 lg:mb-0">
        <p class="text-xl md:text-2xl mb-7 md:mb-16">
          Ahorro por <span class="font-semibold text-nexcar-green">$2.1 millones vs la compra al contado</span>
          y más de <span class="font-semibold text-nexcar-green">$5.5 millones vs crédito</span>
        </p>
        <p class="mb-4 text-base md:text-lg">
          ¿Todavía tienes dudas?
        </p>
        <a
          class="flex items-center justify-center h-8 p-1 text-sm text-white align-text-bottom rounded-md w-52 md:w-72 lg:w-80 md:h-10 md:p-2 lg:h-12 bg-nexcar-green md:text-xl hover:bg-nexcar-dark-green"
          href="/frequent_questions"
        >
          Ir a Preguntas frecuentes
        </a>
      </div>
      <img
        src="../../../assets/images/mazda-ford.svg"
        class="lg:order-first lg:mr-16"
      >
    </div>
    <div class="flex flex-col mb-10 text-gray-700 md:col-span-2 md:mb-20">
      <h2 class="text-xl font-medium lg:text-center lg:text-3xl mb-7 md:mb-9">
        Nexcar te ofrece <span class="text-nexcar-green">múltiples beneficios</span>
      </h2>
      <div class="grid grid-cols-1 mx-auto md:grid-cols-2 max-w-7xl gap-y-6 md:gap-y-9 md:gap-x-12">
        <div class="flex items-center text-sm md:text-base">
          <img
            src="../../../assets/images/icons/nexcar-includes-check.svg"
            class="w-4 h-4 mr-4 md:w-7 md:h-7 md:mr-6"
          >
          No más tramites ni preocupaciones
        </div>
        <div class="flex items-center text-sm md:text-base">
          <img
            src="../../../assets/images/icons/nexcar-includes-check.svg"
            class="w-4 h-4 mr-4 md:w-7 md:h-7 md:mr-6"
          >
          Plan a tu medida, ¡Tú eliges plazo y kilometraje!
        </div>
        <div class="flex items-center text-sm md:text-base">
          <img
            src="../../../assets/images/icons/nexcar-includes-check.svg"
            class="w-4 h-4 mr-4 md:w-7 md:h-7 md:mr-6"
          >
          Renueva constantemente tu auto de manera 100% digital.
        </div>
        <div class="flex items-center text-sm md:text-base">
          <img
            src="../../../assets/images/icons/nexcar-includes-check.svg"
            class="w-4 h-4 mr-4 md:w-7 md:h-7 md:mr-6"
          >
          Sin gastos extras, ¡Tú solo pagas la bencina y el TAG!
        </div>
        <div class="flex items-center text-sm md:text-base">
          <img
            src="../../../assets/images/icons/nexcar-includes-check.svg"
            class="w-4 h-4 mr-4 md:w-7 md:h-7 md:mr-6"
          >
          Sin grandes inversiones, ¡Mayor liquidez para tus cosas!
        </div>
        <div class="flex items-center text-sm md:text-base">
          <img
            src="../../../assets/images/icons/nexcar-includes-check.svg"
            class="w-4 h-4 mr-4 md:w-7 md:h-7 md:mr-6"
          >
          Reduce carga impositiva para las empresas.
        </div>
      </div>
    </div>
    <div class="md:col-span-2 h-0.5 border-gray-200 border-b md:border-b-2 md:w-3/5 w-4/5 justify-self-center mb-10 md:mb-20" />
    <h2 class="mb-5 text-xl font-medium text-center text-gray-700 md:col-span-2 justify-self-center md:text-3xl md:mb-12">
      ¿Por qué Nexcar logra ser más conveniente?
    </h2>
    <div class="grid grid-cols-2 mx-auto mb-10 text-gray-700 md:mb-20 land-custom-grid max-w-7xl gap-x-2 md:gap-x-8 gap-y-2 md:gap-y-20 md:col-span-2">
      <div class="w-20 justify-self-end">
        <img
          src="../../../assets/images/icons/circle-money-symbol-icon.svg"
          class="self-end w-20 h-full p-3 bg-nexcar-second-light-green"
          :class="{ 'opacity-50': this.$root.isMobile && !this.circleMoneyIconSelected,
                    'cursor-pointer': this.$root.isMobile }"
          @click="setIcon('circleMoneyIconSelected')"
        >
      </div>
      <p
        class="col-span-2 mt-5 md:col-span-1 md:mt-0"
        :class="{ 'row-start-3 text-center': this.$root.isMobile && this.circleMoneyIconSelected }"
        v-if="!this.$root.isMobile || this.circleMoneyIconSelected"
      >
        <span class="font-medium">Consigue los mejores precios</span> <br>
        <span class="text-sm">Nos encargamos de buscar las mejores opciones de precio en</span>
        <span class="text-sm text-nexcar-green"> autos, seguros y mantenciones.</span>
      </p>
      <div class="w-20 md:justify-self-end">
        <img
          src="../../../assets/images/icons/sell-buy-better-icon.svg"
          class="w-20 h-full p-3 bg-nexcar-second-light-green"
          :class="{ 'opacity-50': this.$root.isMobile && !this.sellBuyBetterIconSelected,
                    'cursor-pointer': this.$root.isMobile }"
          @click="setIcon('sellBuyBetterIconSelected')"
        >
      </div>
      <p
        class="col-span-2 mt-5 md:col-span-1 md:mt-0"
        :class="{ 'row-start-3 text-center': this.$root.isMobile && this.sellBuyBetterIconSelected }"
        v-if="!this.$root.isMobile || this.sellBuyBetterIconSelected"
      >
        <span class="font-medium">Compra/Vende mejor y más rápido</span> <br>
        <span class="text-sm">Sabemos como</span>
        <span class="text-sm text-nexcar-green">comprar, mantener y vender autos de manera eficiente.</span>
        <span class="text-sm"> Nunca más tendrás que preguntarte donde llevar tu auto.</span>
      </p>
      <div class="w-20 justify-self-end">
        <img
          src="../../../assets/images/icons/tecnology-icon.svg"
          class="self-end w-20 h-full p-3 bg-nexcar-second-light-green"
          :class="{ 'opacity-50': this.$root.isMobile && !this.tecnologyIconSelected,
                    'cursor-pointer': this.$root.isMobile }"
          @click="setIcon('tecnologyIconSelected')"
        >
      </div>
      <p
        class="col-span-2 mt-5 md:col-span-1 md:mt-0"
        :class="{ 'row-start-3 text-center': this.$root.isMobile && this.tecnologyIconSelected }"
        v-if="!this.$root.isMobile || this.tecnologyIconSelected"
      >
        <span class="font-medium">Tecnología</span> <br>
        <span class="text-sm">Utilizamos</span>
        <span class="text-sm text-nexcar-green"> tecnología telemática y GPS</span>
        <span class="text-sm"> para rastrear los vehículos</span>
        <span class="text-sm text-nexcar-green"> con asistencia en ruta 24/7</span>
        <span class="text-sm"> disminuyendo el riesgo de robo.</span>
      </p>
      <div class="md:justify-self-end">
        <img
          src="../../../assets/images/icons/access-icon.svg"
          class="w-20 h-full p-3 bg-nexcar-second-light-green"
          :class="{ 'opacity-50': this.$root.isMobile && !this.accessIconSelected,
                    'cursor-pointer': this.$root.isMobile }"
          @click="setIcon('accessIconSelected')"
        >
      </div>
      <p
        class="col-span-2 mt-5 md:col-span-1 md:mt-0"
        :class="{ 'row-start-3 text-center': this.$root.isMobile && this.accessIconSelected }"
        v-if="!this.$root.isMobile || this.accessIconSelected"
      >
        <span class="font-medium">Financiamiento y redes de beneficios</span> <br>
        <span class="text-sm">Accede a un</span>
        <span class="text-sm text-nexcar-green">  menor costo de financiamiento</span>
        <span class="text-sm"> con Nexcar. <br v-if="!this.$root.isMobile"> Obtén</span>
        <span class="text-sm text-nexcar-green"> múltiples beneficios</span>
        <span class="text-sm"> al ser parte de nuestra red.</span>
      </p>
    </div>
    <div class="md:col-span-2 h-0.5 border-gray-200 border-b md:border-b-2 md:w-3/5 w-4/5 justify-self-center mb-10 md:mb-20" />
    <div class="grid mx-auto mb-10 text-gray-700 md:grid-cols-2 gap-y-2 md:col-span-2 md:gap-x-8 max-w-7xl">
      <img
        src="../../../assets/images/iphone-mobile-view.svg"
        class="md:row-span-1 md:col-span-1 justify-self-center md:order-last"
      >
      <div class="flex flex-col">
        <h2 class="mb-4 text-xl font-medium md:text-3xl md:mb-8">
          ¿Qué incluye la cuota?
        </h2>
        <div class="flex flex-col justify-between md:h-2/3 h-52">
          <div class="flex items-center">
            <img
              src="../../../assets/images/icons/next-step-arrow-icon.svg"
              class="w-4 h-5 mr-4 md:w-4 md:h-6"
            >
            <p class="text-sm md:text-base">
              Auto 0 km en la puerta de tu casa.
            </p>
          </div>
          <div class="flex items-center">
            <img
              src="../../../assets/images/icons/next-step-arrow-icon.svg"
              class="w-4 h-5 mr-4 md:w-4 md:h-6"
            >
            <p class="text-sm md:text-base">
              Mantenciones y revisión técnica a domicilio.
            </p>
          </div>
          <div class="flex items-center">
            <img
              src="../../../assets/images/icons/next-step-arrow-icon.svg"
              class="w-4 h-5 mr-4 md:w-4 md:h-6"
            >
            <p class="text-sm md:text-base">
              Acceso a auto de remplazo en caso de necesitarlo.
            </p>
          </div>
          <div class="flex items-center">
            <img
              src="../../../assets/images/icons/next-step-arrow-icon.svg"
              class="w-4 h-5 mr-4 md:w-4 md:h-6"
            >
            <p class="text-sm md:text-base">
              Seguros con asistencia en ruta 24/7.
            </p>
          </div>
          <div class="flex items-center">
            <img
              src="../../../assets/images/icons/next-step-arrow-icon.svg"
              class="w-4 h-5 mr-4 md:w-4 md:h-6"
            >
            <p class="text-sm md:text-base">
              Tu propia ejecutiva de contrato.
            </p>
          </div>
          <div class="flex items-center">
            <img
              src="../../../assets/images/icons/next-step-arrow-icon.svg"
              class="w-4 h-5 mr-4 md:w-4 md:h-6"
            >
            <p class="text-sm md:text-base">
              Acceso a beneficios Red Nexcar.
            </p>
          </div>
          <div class="flex items-center">
            <img
              src="../../../assets/images/icons/next-step-arrow-icon.svg"
              class="w-4 h-5 mr-4 md:w-4 md:h-6"
            >
            <p class="text-sm md:text-base">
              Y mucho más!
            </p>
          </div>
        </div>
      </div>
    </div>
    <div class="flex mb-10 -mx-6 bg-gray-100 md:col-span-2 md:mb-20">
      <div class="flex flex-col justify-center flex-1 pl-5 md:pl-8 xl:pl-20 xs_padding">
        <p class="mb-4 text-xl font-medium text-gray-700 xs_main_font_size md:text-2xl lg:text-3xl md:mb-6">
          ¡Conoce más de Nexcar aquí!
        </p>
        <button
          class="flex items-center px-2 py-1 text-white rounded-md custom_video_button md:py-3 md:px-4 bg-nexcar-green hover:to-nexcar-dark-green md:text-2xl w-36 md:w-52 lg:rounded-lg"
          @click="showVideoModal"
        >
          <span class="mr-5 xs_buttom_margin">Ver video</span>
          <img
            src="../../../assets/images/icons/play-video-icon.svg"
            class=""
          >
        </button>
      </div>
      <img
        src="../../../assets/images/nexcar-video.svg"
        class="object-scale-down"
        :class="{ 'max-w-sm': this.$root.isMedium }"
        v-if="!this.$root.isMobile"
      >
      <img
        src="../../../assets/images/nexcar-video-mobile.svg"
        class="object-contain"
        v-else
      >
    </div>
    <div class="flex flex-col justify-between col-span-1 mb-10 -mx-6 md:mb-20 md:-mx-0 md:col-span-2">
      <h2 class="px-2 mx-2 mb-6 text-xl text-gray-700 md:text-2xl lg:texl-3xl">
        Conoce la experiencia de <span class="text-nexcar-green">nuestros clientes</span>
      </h2>
      <carousel
        :per-page-custom="[[0, 1], [768, 2], [1024, 3]]"
        :pagination-active-color="'#3F3F46'"
        class="w-full"
      >
        <slide
          v-for="recomendation in recomendations"
          :key="recomendation.completeName"
        >
          <recomendation
            :car-model="recomendation.carModel"
            :car-edition="''"
            :car-reviewer="recomendation.completeName"
            :date="recomendation.date"
            :comment="recomendation.comment"
          />
        </slide>
      </carousel>
    </div>
    <find-your-nexcar />
  </div>
</template>
<script>
import Recomendation from './recomendation.vue';
import FindYourNexcar from '../shared/find-your-nexcar';
import VideoModal from './video-modal.vue';
import PriceComparisonGrid from './price-comparison-grid.vue';
import recomendations from './recomendations.json';

export default {
  components: {
    Recomendation,
    FindYourNexcar,
    PriceComparisonGrid,
  },
  props: {
    brands: { type: Array, default() { return []; } },
  },
  data() {
    return {
      lastIconSelected: 'circleMoneyIconSelected',
      circleMoneyIconSelected: true,
      sellBuyBetterIconSelected: false,
      tecnologyIconSelected: false,
      accessIconSelected: false,
      recomendations: recomendations.recomendations,
    };
  },
  computed: {
    oneQuoteImagePath() {
      if (this.$root.isMobile) return '../../../assets/images/one-quote-landing-with-car-mobile.svg';

      return '../../../assets/images/one-quote-landing-with-car.svg';
    },
  },
  methods: {
    setIcon(iconName) {
      if (this.$root.isMobile) {
        this[this.lastIconSelected] = false;
        this[iconName] = true;
        this.lastIconSelected = iconName;
      }
    },
    getCarsFiltered(brand) {
      window.location = `/cars?brand_id=${brand.id}`;
    },
    showVideoModal() {
      this.$modal.show(VideoModal, {}, {
        width: '100%',
        maxWidth: this.$root.mdScreen,
        height: 'auto',
        adaptive: true,
        scrollable: true,
        name: 'video-modal',
      });
    },
  },
};
</script>
<style lang="scss">
.land-custom-grid {
  @media (min-width: 768px) {
    grid-template-columns: repeat(2, min-content minmax(0, 1fr));
  }
}

.custom_video_button {
  @media (max-width: 325px) {
    width: 120px;
    font-size: 14px;
  }
}

.xs_buttom_margin {
  @media (max-width: 325px) {
    margin-right: 4px;
  }
}

.xs_padding {
  @media (max-width: 325px) {
    padding-left: 8px;
  }
}

.xs_main_font_size {
  @media (max-width: 325px) {
    font-size: 16px;
  }
}
</style>
