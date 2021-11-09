<template>
  <div
    class="flex flex-col w-full h-full p-4 font-main md:p-7"
    v-if="!requestConfirmed"
  >
    <button
      class="self-end mb-2 focus:outline-none"
      @click="closeModal"
    >
      <img
        class="w-6 h-6"
        :src="require('assets/images/close.svg')"
      >
    </button>
    <p class="mb-4 text-xl text-gray-600">
      Confirmación de solicitud
    </p>
    <div class="flex mb-4">
      <img
        :src="this.model.mainImageUrl"
        class="object-scale-down w-56 p-2 mr-6 border rounded-md"
        v-if="!$root.isMobile"
      >
      <div class="w-2 bg-nexcar-green rounded-l-md" />
      <div class="grid flex-1 grid-cols-2 p-2 border border-l-0 rounded-md rounded-l-none gap-y-2">
        <p class="self-end col-span-1 text-2xl text-gray-600 md:col-span-2 md:row-start-2">
          {{ this.model.name }}
        </p>
        <p class="self-end col-span-1 text-lg text-gray-400 md:col-span-2">
          {{ this.model.brandName }}
        </p>
        <p class="self-end col-span-1 text-sm font-light text-gray-600">
          Versión
        </p>
        <p class="self-end col-span-1 mr-4 text-sm font-medium text-nexcar-green justify-self-end">
          {{ this.carVersion.name }}
        </p>
        <p class="self-end col-span-1 text-sm font-light text-gray-600">
          Kilometraje Anual
        </p>
        <p class="self-end col-span-1 mr-4 text-sm font-medium text-nexcar-green justify-self-end">
          {{ this.annualDistance }} km
        </p>
        <p class="self-end col-span-1 text-sm font-light text-gray-600">
          Plazo
        </p>
        <p class="self-end col-span-1 mr-4 text-sm font-medium text-nexcar-green justify-self-end">
          {{ this.contractTime }} meses
        </p>
        <div class="col-span-2 border-b border-gray-100" />
        <p class="self-end col-span-1 mb-2 text-sm font-light text-gray-600">
          Total (mensual)
        </p>
        <p class="self-end col-span-1 mb-2 mr-4 text-sm font-medium text-nexcar-green justify-self-end">
          {{ this.priceVersion.formattedMonthlyPrice }}
        </p>
      </div>
    </div>
    <div class="grid grid-cols-2 mb-4 text-gray-600 md:grid-cols-4 gap-x-2 gap-y-2">
      <p class="col-span-2 mb-2 font-medium md:col-span-4">
        Información Adicional
      </p>
      <label class="md:col-span-1">
        Nombre
        <p
          class="text-xs text-red-500"
          v-if="!firstName && fillMessageAllow"
        >
          {{ fillMessage }}
        </p>
        <input
          ref="nameInput"
          class="w-full p-1 text-xs border rounded-md focus:outline-none"
          :class="{ 'border-red-300': !firstName && fillMessageAllow }"
          v-model="firstName"
          type="text"
        >
      </label>
      <label class="md:col-span-1">
        Apellido
        <p
          class="text-xs text-red-500"
          v-if="!lastName && fillMessageAllow"
        >
          {{ fillMessage }}
        </p>
        <input
          class="w-full p-1 text-xs border rounded-md focus:outline-none"
          :class="{ 'border-red-300': !lastName && fillMessageAllow }"
          v-model="lastName"
          type="text"
        >
      </label>
      <div class="flex items-end col-span-2">
        <label
          class="flex items-center justify-center w-1/2 p-1 border cursor-pointer rounded-l-md hover:bg-nexcar-second-light-green"
          :class="{ 'bg-nexcar-second-light-green border-nexcar-green': this.selectedTypeOfClient === 'company',
                    'border-r-0': this.selectedTypeOfClient === 'person' }"
          @click="setTypeOfClient('company')"
        >
          <img
            src="../../../assets/images/company-icon.svg"
            class="w-5 h-5 mr-2"
          >
          <p class="text-xs">
            Empresa
          </p>
        </label>
        <label
          class="flex items-center justify-center w-1/2 p-1 border border-l-0 cursor-pointer rounded-r-md hover:bg-nexcar-second-light-green"
          :class="{ 'bg-nexcar-second-light-green border-nexcar-green border-l':
            this.selectedTypeOfClient === 'person' }"
          @click="setTypeOfClient('person')"
        >
          <img
            src="../../../assets/images/person-icon.svg"
            class="w-5 h-5 mr-2"
          >
          <p class="text-xs">
            Persona
          </p>
        </label>
      </div>
      <label class="col-span-2 md:col-start-3">
        Correo Electrónico
        <p
          class="text-xs text-red-500"
          v-if="!validEmail && fillMessageAllow"
        >
          {{ fillMessage }} o no está en el formato correcto
        </p>
        <input
          class="w-full p-1 text-xs border rounded-md focus:outline-none"
          :class="{ 'border-red-300': !validEmail && fillMessageAllow }"
          v-model="email"
          type="email"
        >
      </label>
      <label class="col-span-2 md:row-start-3">
        Número de teléfono
        <div class="flex mb-2">
          <div class="flex items-center p-1 text-xs border rounded-l-md">
            +569
          </div>
          <input
            class="w-full p-1 text-xs border border-l-0 rounded-md rounded-l-none focus:outline-none"
            v-model="contactNumber"
            type="text"
          >
        </div>
      </label>
      <label class="col-span-2 md:col-span-4">
        Escríbenos un comentario o color de preferencia
        <textarea
          class="w-full p-1 text-xs border rounded-md focus:outline-none"
          v-model="comment"
          type="text"
        />
      </label>
    </div>
    <button
      class="self-center w-1/2 p-2 text-white border rounded-md bg-nexcar-green focus:outline-none hover:bg-nexcar-dark-green"
      @click="confirm"
    >
      Confirmar
    </button>
    <p
      class="px-1 text-sm text-red-500"
      v-if="errorFound"
    >
      Se ha encontrado un error: {{ errorMessage }}
    </p>
  </div>
  <div
    v-else
    class="flex flex-col items-center p-4"
  >
    <p class="mb-1 text-3xl">
      ¡Gracias {{ this.firstName }} por tu solicitud! <br>
    </p>
    <p class="mb-4 text-2xl">
      Pronto te contactaremos
    </p>
    <button
      class="self-center w-1/2 p-1 text-white border rounded-md bg-nexcar-green hover:bg-nexcar-dark-green focus:outline-none"
      @click="closeModal"
    >
      Cerrar
    </button>
  </div>
</template>
<script>
import reservatioRequestApi from '../../api/reservation_request';
import formattedEmail from '../mixins/formattedEmail';

export default {
  mixins: [formattedEmail],
  props: {
    model: { type: Object, require: true, default() { return {}; } },
    carVersion: { type: Object, require: true, default() { return {}; } },
    priceVersion: { type: Object, require: true, default() { return {}; } },
    annualDistance: { type: String, require: true, default: '' },
    contractTime: { type: String, require: true, default: '' },
    typeOfClients: { type: Array, require: true, default() { return []; } },
  },
  data() {
    return {
      email: '',
      firstName: '',
      lastName: '',
      contactNumber: '',
      selectedTypeOfClient: this.typeOfClients[1].key,
      comment: '',
      requestConfirmed: false,
      errorFound: false,
      errorMessage: '',
      fillMessage: 'Falta completar este campo',
      fillMessageAllow: false,
    };
  },
  mounted() {
    this.$refs.nameInput.focus();
  },
  computed: {
    completeAttributes() {
      return this.validEmail && this.firstName && this.lastName;
    },
    missingAttributes() {
      return !this.completeAttributes;
    },
  },
  methods: {
    setTypeOfClient(typeOfClient) {
      this.selectedTypeOfClient = typeOfClient;
    },
    confirm() {
      if (this.completeAttributes) {
        this.sendRequest();
      } else {
        this.fillMessageAllow = true;
      }
    },
    async sendRequest() {
      const body = { 'carId': this.carVersion.id, 'priceVersionId': this.priceVersion.id,
        'email': this.email, 'firstName': this.firstName, 'lastName': this.lastName,
        'contactNumber': this.contactNumber, 'kind': this.selectedTypeOfClient,
        'comment': this.comment };
      try {
        await reservatioRequestApi.createReservationRequest(body);
        this.requestConfirmed = true;
      } catch (error) {
        this.errorMessage = error;
        this.errorFound = true;
      }
    },
    closeModal() {
      this.$modal.hide('reservation-request-modal');
    },
  },
};
</script>
