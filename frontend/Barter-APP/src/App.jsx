import { useState } from "react";
import reactLogo from "./assets/react.svg";
import "./App.css";
import { Routes, Route } from "react-router-dom";
import Login from "./LandNav/Login/Login";
import Profile2 from "./LandNav/Profile2/Profile2";
import LandingNav from "./LandNav/LandingNav";
import SignupMain from "./LandNav/SignupPage/SignupMain";
import Pro from "./LandNav/pro/Pro";
import Cart from "./LandNav/Cart/Cart";
import FirstModal from "./LandNav/FirstModal/FirstModal";
import Verify from "./LandNav/Verification/Verify";
import { AccessProvider } from "./LandNav/ContextApi/Context";
import Forgetpassword from "./LandNav/ForgetPass/Forgetpassword";
import ResetPassword from "./LandNav/ResetPass/ResetPassword";
import RealProfile from "./LandNav/realProfile/RealProfile";

function App() {
  return (
    <div className="App">
      <AccessProvider>
        <Routes>
          <Route path="/" element={<LandingNav />} />
          <Route path="/signup" element={<SignupMain />} />
          <Route path="/login" element={<Login />} />
          <Route path="/pro" element={<Pro />} />
          <Route path="/cart" element={<Cart />} />
          <Route path="/signuploginmodal" element={<FirstModal />} />
          <Route path="/verify" element={<Verify />} />
          <Route path="/item/:profile2Id" element={<Profile2 />} />
          <Route path="/forgetpassword" element={<Forgetpassword />} />
          <Route path="resetpassword" element={<ResetPassword />} />
          <Route path="/profile" element={<RealProfile />} />
        </Routes>
      </AccessProvider>
    </div>
  );
}

export default App;
