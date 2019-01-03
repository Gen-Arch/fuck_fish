
import Axios from 'axios';
export default Axios.create({
  baseURL: 'http://localhost/fuck_fish',
  headers: {
    'Content-Type': 'application/json',
    'X-Requested-With': 'XMLHttpRequest'
  },
  responseType: 'json'  
});
