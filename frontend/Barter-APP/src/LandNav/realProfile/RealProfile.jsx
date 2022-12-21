import React from "react";
import "./RealProfile.css";
import { Link, useParams } from "react-router-dom";
import { useContext } from "react";
import { AccessProv } from "../ContextApi/Context";
import { useState, useEffect } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";

function RealProfile() {
  const [email, setEmail] = useState();
  const [username, setUsername] = useState();
  const [phonenumber, setPhonenumber] = useState();
  const { access, setAccess } = useContext(AccessProv);
  const navigate = useNavigate();

  const getUserProfile = () => {
    // e.preventDefault();
    console.log(access);

    axios
      .get(
        "https://tech-driven-trade-by-barter-backend.onrender.com/api/v1/user/getUserProfile",
        {
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${access.token}`,
          },
        }
      )
      .then((result) => {
        console.log(result.data.profile[0].username);
        setEmail(result.data.profile[0].email);
        setUsername(result.data.profile[0].username);
        setPhonenumber(result.data.profile[0].phonenumber);
      });
  };

  useEffect(() => {
    getUserProfile();
  });

  const submit = (e) => {
    e.preventDefault();
    const data = { email, phonenumber, username };
  };

  const isloggedOut = () => {
    const stateReset = {
      isLoggedIn: false,
      token: "",
      userId: "",
    };
    localStorage.setItem("user", JSON.stringify(stateReset));
    setAccess(stateReset);
    navigate("/login");
  };
  return (
    <div className="conProfile">
      <form onSubmit={submit}>
        <h1>Profile</h1>
        <div className="profileImgEdit">
          <div className="profileImg">
            <img src="" alt="" />
          </div>
          <div className="profileLink">
            <Link>Edith</Link>
          </div>
        </div>

        <div>
          <div className="inputName">
            <label htmlFor="display name">
              <p> Display Name</p>
            </label>
            <input
              value={username}
              placeholder="Name"
              id="display name"
              className="inputPart"
              onChange={(e) => setUsername(e.target.value)}
            />
          </div>
          <br />
          <div className="inputPhone">
            <label htmlFor="phone">
              {" "}
              <p> Phone Number</p>
            </label>
            <input
              value={phonenumber}
              name="phone"
              id="phone"
              placeholder="phonesnumber"
              className="inputPart"
              onChange={(e) => phonenumber(e.target.value)}
            />
          </div>
          <br />
          <div className="inputEmail">
            <label htmlFor="phone">
              {" "}
              <p> Email</p>
            </label>
            <input
              value={email}
              name="phone"
              id="phone"
              placeholder=" email"
              className="inputPart"
              onChange={(e) => setEmail(e.target.value)}
            />
          </div>
          <br />
          <div className="logoutBtn">
            <button type="submit" className="logout">
              Submit
            </button>
          </div>
          <br />
          <div className="logoutBtn"></div>
        </div>
        <br />
        <button type="submit" onClick={isloggedOut}>
          logout
        </button>
      </form>
    </div>
  );
}

export default RealProfile;
