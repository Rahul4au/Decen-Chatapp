import React, {Children, useEffect, useState} from "react";
import { useRouter } from "next/router";


//Internal Import
 import {CheckIfWalletConnected, connectWallet, fetchContract, connectingWithContract} from '../Utils/apiFeature';

export const ChatAppContext = React.createContext();

export const ChatAppProvider = ({Children}) => {
    const title = "Hey Welcome to the Blockchain Chat App";

    return(
        <ChatAppProvider.Provider value={(title)}>
            {Children}
        </ChatAppProvider.Provider>
    )
};