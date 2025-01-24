import './App.css';
import Navbar from '../Components/Navbar/Navbar';
import Filter from '../Components/Filter/Filter';
import Error from '../Components/Error/Error';
import Friend from '../Components/Friend/Friend';
import UserCard from '../Components/UserCard/UserCard';
import Loader from '../Components/Loader/Loader';
import Model from '../Components/Model/Model';
import { Component } from 'react';

import { ChatAppProvider } from '../Context/chatAppContext';
import Navbar from '../Components/Components/Navbar';
function MyApp() {
  return (
    <div>
      
      <ChatAppProvider>
        <Navbar/>
        <Component {...pageProp} />
      </ChatAppProvider>
    </div>
  );
}

export default MyApp ;
