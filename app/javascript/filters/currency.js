const mapCurrencyToLocale = {
  USD: { locale: 'en-CA', fracionDigits: 2 },
  CLP: { locale: 'es-CL', fracionDigits: 0 },
  EUR: { locale: 'de-DE', fracionDigits: 2 },
};

export default function currency(value, curr) {
  const formatter = new Intl.NumberFormat(mapCurrencyToLocale[curr].locale, {
    style: 'currency',
    currency: curr,
    minimumFractionDigits: mapCurrencyToLocale[curr].fracionDigits,
    currencyDisplay: 'symbol',
    maximumFractionDigits: 2,
    useGrouping: true,
  });
  // eslint-disable-next-line no-magic-numbers
  const valueWithDecimals = value / (10 ** mapCurrencyToLocale[curr].fracionDigits);
  let formattedValue = `${formatter.format(valueWithDecimals)}`;
  if (value < 0) {
    formattedValue = `${formattedValue.replace('-', '')}`;
  }

  return formattedValue;
}
