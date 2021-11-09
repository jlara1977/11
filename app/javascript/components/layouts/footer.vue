<template>
  <div class="grid grid-cols-1 text-sm text-white bg-gray-700 md:grid-rows-1 md:grid-cols-3 py-9 font-main">
    <div class="flex row-start-3 px-5 md:row-start-1 md:flex-col">
      <div class="flex flex-col w-full md:mb-10 md:px-0">
        <a
          href="/"
          class="self-start cursor-pointer md:self-center w-28 md:mx-5 md:my-3 md:w-auto"
        >
          <img
            :src="require('assets/images/nexcar-logo-white.svg')"
          >
        </a>
        <p class="self-start md:self-center text-xxs md:text-sm">
          ©2020 by Nexcar Renting Group
        </p>
      </div>
      <img
        :src="require('assets/images/udd-ventures-corfo-start-up-chile.svg')"
        class="self-start w-40 md:self-center md:w-auto"
      >
    </div>
    <div class="flex flex-col row-start-2 py-5 md:w-1/2 md:ml-auto md:row-start-1">
      <p class="self-center mb-4 md:self-start">
        Visita nuestras redes sociales:
      </p>
      <div class="flex justify-center md:justify-start">
        <a
          :href="linkedinLink"
          target="_blank"
        >
          <img
            :src="require('assets/images/icons/linkedin-icon.svg')"
            class="w-6 h-6 mr-4"
          >
        </a>
        <a
          :href="instagramLink"
          target="_blank"
        >
          <img
            :src="require('assets/images/icons/instagram-icon.svg')"
            class="w-6 h-6 mr-4"
          >
        </a>
        <a
          :href="facebookLink"
          target="_blank"
        >
          <img
            :src="require('assets/images/icons/facebook-icon.svg')"
            class="w-6 h-6 mr-4"
          >
        </a>
      </div>
    </div>
    <div class="flex flex-col row-start-1 py-5 mx-auto">
      <p class="mb-4">
        Contáctanos a través de:
      </p>
      <div class="flex mb-4">
        <img
          :src="require('assets/images/phone-contact-icon.svg')"
          class="w-6 h-6 mr-2"
        >
        <p>
          {{ whatsappContact }}
        </p>
      </div>
      <div class="flex mb-4">
        <img
          :src="require('assets/images/location-icon.svg')"
          class="w-6 h-6 mr-2"
        >
        <p>
          {{ officeAddress }}
        </p>
      </div>
      <div class="flex mb-4">
        <img
          :src="require('assets/images/email-icon.svg')"
          class="w-6 h-6 mr-2"
        >
        <p class="underline text-nexcar-green">
          {{ emailContact }}
        </p>
      </div>
    </div>
  </div>
</template>
<script>
/* eslint-disable no-undef */
export default {
  data() {
    return {
      tooltipClassesOption: ['bg-white text-gray-700 text-xs font-main p-2 rounded-md mt-1 w-48'],
    };
  },
  computed: {
    linkedinLink() {
      return process.env.LINKEDIN_LINK || 'likedin';
    },
    instagramLink() {
      return process.env.INSTAGRAM_LINK || 'instagram';
    },
    facebookLink() {
      return process.env.FACEBOOK_LINK || 'facebook';
    },
    whatsappContact() {
      return process.env.WHATSAPP_CONTACT || '+569 39522713';
    },
    officeAddress() {
      return process.env.OFFICE_ADDRESS || 'Santiago, Chile';
    },
    emailContact() {
      return process.env.EMAIL_CONTACT || 'contacto@nexcar.cl';
    },
  },
};
</script>
