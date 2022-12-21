import React from "react";
import { Link } from "react-router-dom";
import "./firstModal.css";

function FirstModal() {
  return (
    // <div className="overallCon">
    <div className="majorCon">
      <Link to={"/"}>
        <button className="cancel">x</button>
      </Link>
      <div className="conModal">
        <h1>Login or register to view and exchange items</h1>
        <h1>WeBarter</h1>
        <br />
        <div className="btnEmail-btnGoogle">
          <Link to={"/login"}>
            {" "}
            <button className="btnEmail">Continue with Email</button>
          </Link>
          <br />
          <Link to={"google.com"}>
            <button className="btnGoogle">Continue with Google</button>
          </Link>
        </div>
      </div>
    </div>
    // </div>
  );
}

export default FirstModal;
