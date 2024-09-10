const hostnameSymbol = Symbol('hostname');
let lineNo = 0;

prompt = () => {
  if (!db[hostnameSymbol]) db[hostnameSymbol] = db.serverStatus().host;
  return `[${db.getName()}@${db[hostnameSymbol]}:\ue7a4]\uf054\uf054`;
};
