import { useState, useEffect } from 'react'
import './App.css'

function App() {
  const [message, setMessage] = useState("");

  useEffect(() => {
    fetch("/api/msg")
      .then((res) => res.json())
      .then((data) => setMessage(data.message))
      .catch((err) => {
        console.error("failed to fetch", err)
      });
  }, [])

  return (
    <>
      <h1>welcome to vs code</h1>
      <p>data: {message}</p>
    </>
  )
}

export default App