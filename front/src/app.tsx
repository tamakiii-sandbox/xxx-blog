import React, { useState, useEffect } from "react";

interface User {
  id: number;
  display_name: string;
}

export default function App() {
  const [users, setUsers] = useState<User[]>([]);
  useEffect(() => {
    (async () => {
      const url = new URL('/users', 'https://localhost/');
      console.log(url.toString());
      const response = await fetch(url.toString(), {
        method: "GET",
        credentials: "same-origin",
        headers: {
          "X-REQUESTED-WITH": "XMLHttpRequest",
          "Accept": "application/json",
          "Content-Type": "application/json",
        }
      })

      if (!response.ok) {
        const body = (await response.json());
        // return { ok: false, body }
      }

      const body = (await response.json());
      console.log(body);
      // return { ok: true, body };
    })()
  }, [])

  return (
    <>
      <h1>Users</h1>
      {}
      <ul></ul>
      <hr />
    </>
  )
}