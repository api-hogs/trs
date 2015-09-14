import icAjax from 'ic-ajax';
import config from 'trs-ember/config/environment';

export default function ajax(url, ...args) {
  let fullUrl = `${config.host}/${config.apiNamespace}${url}`;

  return icAjax(fullUrl, ...args);
}
