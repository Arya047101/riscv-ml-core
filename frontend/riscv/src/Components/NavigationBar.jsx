import React from 'react';
import './NavigationBar.css';
import riscvlogo from './Assets/riscv.png';

function NavigationBar() {
  return (
    <nav className="navbar">
        <div className="nav-logo">
        <img src={riscvlogo} alt="Logo of RISC-V" className="logo-image" />
      </div>
      <div className="nav-title">RISC-V WITH ML ACCELERATOR</div>
    </nav>
  );
}

export default NavigationBar;
