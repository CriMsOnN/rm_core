import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './components/App';
import { VisibilityProvider } from './providers/VisibilityProvider';
import { ChakraProvider, DarkMode } from '@chakra-ui/react';
import { theme } from './theme';

ReactDOM.render(
  <React.StrictMode>
    <ChakraProvider theme={theme}>
      <VisibilityProvider>
        <DarkMode>
          <App />
        </DarkMode>
      </VisibilityProvider>
    </ChakraProvider>
  </React.StrictMode>,
  document.getElementById('root')
);
