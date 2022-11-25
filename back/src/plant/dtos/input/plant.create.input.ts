export const plantCreateBodySchema = {
  type: 'object',
  required: ['macAddress', 'serialNumber'],
  properties: {
    macAddress: { type: 'string', pattern: '^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$' },
    serialNumber: { type: 'string', minLength: 1, maxLength: 255 },
  },
};
