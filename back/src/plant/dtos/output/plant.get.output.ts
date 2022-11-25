export const plantGetResponseSchema = {
  '2xx': {
    type: 'object',
    properties: {
      id: { type: 'string' },
      name: { type: 'string' },
      serialNumber: { type: 'string' },
      macAddress: { type: 'string' },
      datas: {
        type: 'array',
        items: {
          type: 'object',
          properties: {
            temperature: { type: 'number' },
            humidityAir: { type: 'number' },
            humiditySoil: { type: 'number' },
            pressure: { type: 'number' },
            battery: { type: 'number' },
            light: { type: 'number' },
            water: { type: 'number' },
          },
        },
      },
    },
  },
};
