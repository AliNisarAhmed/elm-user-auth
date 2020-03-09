import './main.css';
import { Elm } from './Main.elm';

const app = Elm.Main.init({
  node: document.getElementById('root'),
  flags: localStorage.getItem('token')
});

app.ports.saveToken.subscribe((token) => {
  console.log('token in JS: ', token);
  if (token === null) {
    localStorage.removeItem('token');
  } else {
    localStorage.setItem('token', token);
  }
})

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
// serviceWorker.unregister();
