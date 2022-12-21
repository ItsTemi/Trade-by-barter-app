import React from "react";
import "./Nav.css";
import { useState, useEffect } from "react";
import CurveLoading from "./Image/CurveLoading.gif";
import groupGuyface from "./Image/group2Guyface.jpeg";
import group2Hello from "./Image/groupsHello.jpg";
import group2Bags from "./Image/group2Bags.jpeg";
import group2Ladyface from "./Image/group2Ladyface.jpeg";
import group2Laptop from "./Image/group2Laptop.jpeg";
import group2Watch from "./Image/group2Watch.jpeg";
import Likegroup2 from "./Image/Likegroup2.png";
import { Link, useParams } from "react-router-dom";
import { useNavigate } from "react-router-dom";
import Nav from "./Nav";
import { useContext } from "react";
// import { AccessProvider } from "react";
import { AccessProv } from "./ContextApi/Context";
import axios from "axios";
// import { useContext } from "react";
// import { useParams } from "react-router-dom"

const url = `https://tech-driven-trade-by-barter-backend.onrender.com/api/v1/item/getAllItems`;
const url2 =
  "https://tech-driven-trade-by-barter-backend.onrender.com/api/v1/like/createLike/";

function LandingNav() {
  const [isLoading, setIsLoading] = useState(true);
  const [itemm, setItemm] = useState([]);
  const { access, setAccess } = useContext(AccessProv);
  const { likes, setLikes } = useContext(AccessProv);

  console.log(itemm);
  const navigate = useNavigate();
  console.log(access);

  const likeItem = (_id) => {
    axios.post(url2 + _id).then((result) => {
      console.log(result);
      setLikes(likes + 1);
    });
  };

  const fetchItem = () => {
    axios.get(url).then((result) => {
      console.log(result);

      setItemm(result.data);
      setIsLoading(false);

      setTimeout(() => {
        console.log(access);
      }, 4000);
    });
  };
  useEffect(() => {
    fetchItem();
    console.log(access);
    if (!access?.isLoggedIn) {
      navigate("/login");
    }
  }, []);

  //   useEffect(() => {
  //     loginPage();
  //   });

  //   const loginPage = () => {
  //     if (!login) {
  //       navigate("/login");
  //     } else if (login) {
  //       navigate("/signup");
  //     }

  //     navigate("/");
  //   };

  if (isLoading) {
    return (
      <div className="loading">
        <img src={CurveLoading} alt="" />
        <h1>Loading...</h1>
      </div>
    );
  }

  return (
    <div>
      <Nav access={access} />
      <div className="LinkCon">
        <div className="genImgWri">
          <div className="write">
            Exchange the products you have <br />
            for the ones you want on WEBARTER. <br />
            No charges, Free
            <br />
            <br />
            <div className="btn">
              <button>GET STARTED</button>
            </div>
          </div>
          <div className="genConImg">
            <div className="firstImg">
              <div className="guy">
                <img src={groupGuyface} alt="face" />
              </div>
              <div className="hello">
                <img src={group2Hello} alt="book" />
              </div>
              <div className="bag">
                <img src={group2Bags} alt="bag" />
              </div>
            </div>
            <div className="secImg">
              <div className="lady">
                <img src={group2Ladyface} alt="face" />
              </div>
              <div className="laptop">
                <img src={group2Laptop} alt="laptop" />
              </div>
              <div className="watch">
                <img src={group2Watch} alt="watch" />
              </div>
            </div>
          </div>
        </div>
      </div>
      <div className="overAllCon">
        <div className="majorContainer">
          <button className="btnProduct"> OUR PRODUCTS</button>
          <section className="minorContainer">
            {itemm.items.map((item, k) => {
              const {
                _id,
                photos,
                itemName,
                location,
                description,
                userLike,
                isFavorite,
              } = item;
              return (
                <Link key={k} to={`/item/${_id}`}>
                  {/* <Link key={k} to={item._id} >  */}
                  {/* to={`/${i.id}`} */}
                  <div className="ImageCon">
                    <img src={photos[0]} alt="" />

                    <div>
                      <div>{itemName} </div> <br />
                      {description}
                      {location}
                      <br />
                      <br />
                      {userLike}
                      <button
                        onClick={() => {
                          likeItem(_id);
                        }}
                      >
                        <div className="like ">
                          <img
                            src={Likegroup2}
                            alt=""
                            className={isFavorite ? `redColor` : `whiteColor`}
                          />
                        </div>
                      </button>
                    </div>
                  </div>
                </Link>
              );
            })}
          </section>

          <button className="btnAll">VIEW ALL</button>
        </div>

        <footer>
          <div>Copyright &copy; 2022 webarter</div>
          <div>Privacy-policy</div>
        </footer>
      </div>
    </div>
  );
}

export default LandingNav;
