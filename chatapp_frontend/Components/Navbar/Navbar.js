import React,{useEffect,useState,useContext} from 'react';
import Style from './Navbar.css';
import Image from "next/image";
import Link from "next/link";

import { ChatAppContext } from '../../Context/chatAppContext';
import Model from '../Model/Model';
import Error from '../Error/Error';
import images from "../assets";

const Navbar = () => {

  const menuItems = [
    {
      menu:"All Users",
      link:"alluser"
    },
    {
      menu:"Chat",
      link:"/"
    },{
      menu:"Contact",
      link:"/"
    },{
      menu:"Settings",
      link:"/"
    },
    {
      menu:"FAQs",
      link:"/"
    },
    {
      menu:"Terms of Use",
      link:"/"
    },
  ];

  const[active,setActive] = useState(2);
  const[open, setOpen] = useState(false);
  const [openModel,setOpenModel] = useState(false);

  const[account,userName, connectwallet] = useContext(ChatAppContext);
  
  return (
    <div className={style.Navbar}>
      <div className={style.Navbar_box}></div>
    </div>
    );
};

export default Navbar