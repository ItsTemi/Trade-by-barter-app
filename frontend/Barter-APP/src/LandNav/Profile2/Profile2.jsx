import React from "react";
import "../Profile2/Profile2.css";
import CurveLoading from "../Image/CurveLoading.gif";
import { IoIosWarning } from "react-icons/io";
import { useParams } from "react-router-dom";
import { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import Nav from "../Nav";
import { useContext } from "react";
// import { AccessProvider } from "react";
import { AccessProv } from "../ContextApi/Context";
import axios from "axios";

// const url="https://we-barter--app.herokuapp.com/api/v1/item/getSingleItem/"

function Profile2() {
  const { profile2Id } = useParams();
  const [display, setDisplay] = useState("");
  const [isLoading, setIsLoading] = useState(true);
  const { access } = useContext(AccessProv);

  const fetchItem = () => {
    // const response = await fetch(url)
    // const response = await fetch(
    //   `https://tech-driven-trade-by-barter-backend.onrender.com/api/v1/item/getSingleItem/${profile2Id}`
    // );
    // const result = await response.json();
    axios
      .get(
        `https://tech-driven-trade-by-barter-backend.onrender.com/api/v1/item/getSingleItem/${profile2Id}`
      )
      .then((result) => {
        setDisplay(result.data.item[0]);
        // setDisplay(result.photos[1])
        setIsLoading(false);
        console.log(result.data.item[0]);
      });
  };

  useEffect(() => {
    fetchItem();
  }, []);

  if (isLoading) {
    return (
      <div className="loading">
        <img src={CurveLoading} alt="" />
        <h1>Loading...</h1>
      </div>
    );
  }

  return (
    // <div>Working</div>
    <div>
      <Nav access={access} />
      <div className="profile2-main-body">
        <div className="profile2-main-container">
          <div className="profile2-small-boxes">
            <div className="small-boxes">
              <img src={display?.photos[2]} alt="" srcset="" />
            </div>
            <br />
            <div className="small-boxes">
              <img src={display?.photos[2]} alt="" srcset="" />
            </div>
            <br />
            <div className="small-boxes">
              <img src={display?.photos[2]} alt="" srcset="" />
            </div>
            <br />
          </div>
          <div className="profile2-middle-box">
            <div className="middle-box-item">
              <img src={display?.photos[0]} alt="" srcset="" />
            </div>
          </div>
          <div className="profile2-third-box">
            <div className="third-box1">
              <div className="third-box-div">
                <h1>{display?.itemName}</h1>
                <br />
                <h2>{display?.description}</h2>
                <br />
                <h2>{display?.location}</h2>
                <br />
                {/* <h4>Size : L/XL</h4> */}
              </div>
            </div>
            <hr />
            <div className="third-box2">
              <h1>Owned by Temitope.S</h1>

              <div className="profile-picture"></div>
            </div>
            <hr />
            <div className="third-box3">
              <p>
                <IoIosWarning className="warn-icon" />
                Report this listing
              </p>
            </div>
            <hr />
            <div className="third-box4">
              <button className="profile2-btn1">
                <Link to={"https://wa.me/qr/+2348163655938"}>
                  <h2>Chat</h2>
                </Link>
              </button>
              <br />
              <button className="profile2-btn2">
                <Link to={"/"}>
                  <h2>Call</h2>
                </Link>
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Profile2;
