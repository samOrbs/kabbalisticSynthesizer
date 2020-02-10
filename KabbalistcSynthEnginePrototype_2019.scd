
/*

Kabbalistic Synthesizer Prototype.
Copyright (C) <2020> <Sam Conran>

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA


*/

/***
 *    {__               {__      {__                 {__            {__                                            {__
 *    {__               {__      {__                 {__ {_         {__   {_                                       {__  {__                       {_
 *    {__  {__   {__    {__      {__         {__     {__    {____ {_{_ {_      {___      {____ {__   {__{__ {__  {_{_ {_{__        {__     {____    {____ {__   {__    {_ {___
 *    {__ {__  {__  {__ {__ {__  {__ {__   {__  {__  {__{__{__      {__  {__ {__        {__     {__ {__  {__  {__  {__  {_ {_    {_   {__ {__    {__     {__  {_   {__  {__
 *    {_{__   {__   {__ {__   {__{__   {__{__   {__  {__{__  {___   {__  {__{__           {___    {___   {__  {__  {__  {__  {__{_____ {__  {___ {__   {__   {_____ {__ {__
 *    {__ {__ {__   {__ {__   {__{__   {__{__   {__  {__{__    {__  {__  {__ {__            {__    {__   {__  {__  {__  {_   {__{_            {__{__  {__    {_         {__
 *    {__  {__  {__ {___{__ {__  {__ {__    {__ {___{___{__{__ {__   {__ {__   {___     {__ {__   {__   {___  {__   {__ {__  {__  {____   {__ {__{__{________  {____   {___
 *                                                                                              {__
-->PANEL CONTROLS: 8pi lag
-->magnetude = simulates the amount of field force,
-->fieldSpread = the offset between left and right channel, low setting create binaural beating oscillations,
-->mIndexTweak = the index amount in the fm system, creates more complex sprectra,
-->tweakRayLevel = the amplitude amount of the simulated ray
-->cosmicRayFreq = how ofter simulated cosmic rays will arrive
-->cosmicRayAtt = the attack of the cosmic rays impulse

*/


(
~mindex = 1352;

SynthDef(\ksynProto,{| out, microTesla = 30, fieldSpread = 0.11, magnetude = 1, mIndexTweak = 1, tweakRayLength = 1, tweakRayLevel = 100, cosmicRayFrequency = 1, cosmicRayAttack = 1pi |

var signal, nodeOne, nodeTwo, nodeThree, nodeFour, nodeFive, nodeSix, nodeSeven, nodeEight, nodeNine, nodeTen, nodeEleven, nodeTwelve,
uT, uT2, uT3, uT4, uT5, uT6, uT7, uT8, uT9, uT10, uT11, uT12, uT13, uT14, uT15, uT16, uT17, uT18, uT19, uT20, uT21, uT22, uT23, uT24;

microTesla = Lag.kr(microTesla,8pi);
fieldSpread = Lag.kr(fieldSpread,8pi);
magnetude = Lag.kr(magnetude,8pi);
mIndexTweak = Lag.kr(mIndexTweak,8pi);

/*PRIMARY TREE*/

uT = (microTesla + LFNoise1.kr(0.5,mul:0.5) * magnetude); // lfnoise is to simulate the flucuations of the magnetometer.
uT2 = uT + fieldSpread;
uT3 = uT2 + fieldSpread;
uT4 = uT3 + fieldSpread;
uT5 = uT4 + fieldSpread;
uT6 = uT5 + fieldSpread;
uT7 = uT6 + fieldSpread;
uT8 = uT7 + fieldSpread;
uT9 = uT8 + fieldSpread;
uT10 = uT9 + fieldSpread;
uT11 = uT10 + fieldSpread;
uT12 = uT11 + fieldSpread;


nodeOne = SinOsc.ar( [ uT + SinOsc.ar( ( uT / 2 ), 0 , mul: (( uT / ~mindex ) + Env.perc( cosmicRayAttack, 1, tweakRayLevel, -4).kr( gate: Dust.ar(cosmicRayFrequency), timeScale: tweakRayLength )) + mIndexTweak ), uT2 + ( SinOsc.ar( ( uT2 / 2 ), 0 , mul: (( uT2 / ~mindex ) + Env.perc( cosmicRayAttack, 1, tweakRayLevel, -4).kr( gate: Dust.ar(cosmicRayFrequency), timeScale: tweakRayLength)) + mIndexTweak )) ], mul: LFNoise1.kr([ 0.5, 0.5 ], mul: 0.5 )); // uses dust ugen inside sinosc amplitide to simulate cosmic rays

nodeTwo = SinOsc.ar( [ uT3 + SinOsc.ar( (uT3 / 2), 0 , mul: (( uT3 / ~mindex ) + Env.perc( cosmicRayAttack, 1, tweakRayLevel, -4).kr( gate: Dust.ar(cosmicRayFrequency), timeScale: tweakRayLength )) + mIndexTweak ), uT4 + ( SinOsc.ar( ( uT4 / 2 ), 0 , mul:(( uT4 / ~mindex ) + Env.perc( cosmicRayAttack, 1, tweakRayLevel, -4).kr( gate: Dust.ar(cosmicRayFrequency), timeScale: tweakRayLength)) + mIndexTweak )) ], mul: LFNoise1.kr([ 0.5, 0.5 ], mul: 0.5 ));

nodeThree = SinOsc.ar( [ uT5 + SinOsc.ar( (uT5 / 2), 0 , mul: (( uT5 / ~mindex ) + Env.perc( cosmicRayAttack, 1, tweakRayLevel, -4 ).kr( gate: Dust.ar(cosmicRayFrequency), timeScale: tweakRayLength )) + mIndexTweak ), uT6 + ( SinOsc.ar( ( uT6 / 2 ), 0 , mul: (( uT6 / ~mindex )+ Env.perc( cosmicRayAttack, 1, tweakRayLevel, -4 ).kr( gate: Dust.ar(cosmicRayFrequency), timeScale: tweakRayLength )) + mIndexTweak )) ], mul: LFNoise1.kr([ 0.5, 0.5 ], mul: 0.5 ));

nodeFour = SinOsc.ar( [ uT7 + SinOsc.ar( ( uT7 / 2 ), 0 , mul: (( uT7 / ~mindex ) + Env.perc( cosmicRayAttack, 1, tweakRayLevel, -4 ).kr( gate: Dust.ar(cosmicRayFrequency), timeScale: tweakRayLength )) + mIndexTweak ), uT8 + ( SinOsc.ar( ( uT8 / 2 ), 0 , mul: (( uT8 / ~mindex ) + Env.perc( cosmicRayAttack, 1, tweakRayLevel, -4).kr( gate: Dust.ar(cosmicRayFrequency), timeScale: tweakRayLength )) + mIndexTweak )) ], mul: LFNoise1.kr([0.5,0.5], mul:0.5 ));

nodeFive = SinOsc.ar( [ uT9 + SinOsc.ar( ( uT9 / 2 ), 0 , mul: (( uT9 / ~mindex ) + Env.perc( cosmicRayAttack, 1, tweakRayLevel, -4 ).kr( gate: Dust.ar(cosmicRayFrequency), timeScale: tweakRayLength )) + mIndexTweak ), uT10 + ( SinOsc.ar( ( uT10 / 2 ), 0 , mul: (( uT10 / ~mindex ) + Env.perc( cosmicRayAttack, 1, tweakRayLevel, -4 ).kr( gate: Dust.ar(cosmicRayFrequency), timeScale: tweakRayLength )) + mIndexTweak )) ], mul: LFNoise1.kr([ 0.5, 0.5 ], mul: 0.5 ));

nodeSix = SinOsc.ar( [ uT11 + SinOsc.ar( ( uT11 / 2 ), 0 , mul: (( uT11 / ~mindex ) + Env.perc( cosmicRayAttack, 1, tweakRayLevel, -4 ).kr( gate: Dust.ar(cosmicRayFrequency), timeScale: tweakRayLength )) + mIndexTweak ), uT12 + ( SinOsc.ar( ( uT12 / 2 ), 0 , mul: (( uT12 / ~mindex ) + Env.perc( cosmicRayAttack, 1, tweakRayLevel, -4 ).kr( gate: Dust.ar(cosmicRayFrequency), timeScale: tweakRayLength )) + mIndexTweak )) ], mul: LFNoise1.kr( [ 0.5, 0.5 ], mul: 0.5 ));


/*REVERSE BIAS CLONE*/

uT13 = (microTesla - LFNoise1.ar(0.5,mul:0.5) * magnetude);
uT14 = uT13 - fieldSpread;
uT15 = uT14 - fieldSpread;
uT16 = uT15 - fieldSpread;
uT17 = uT16 - fieldSpread;
uT18 = uT17 - fieldSpread;
uT19 = uT18 - fieldSpread;
uT20 = uT19 - fieldSpread;
uT21 = uT20 - fieldSpread;
uT22 = uT21 - fieldSpread;
uT23 = uT22 - fieldSpread;
uT24 = uT23 - fieldSpread;


nodeSeven = SinOsc.ar( [  uT13 + SinOsc.ar( ( uT13 / 2 ), 0 , mul: (( uT13 / ~mindex ) + Env.perc( cosmicRayAttack, 1, tweakRayLevel, -4 ).kr( gate: Dust.ar(cosmicRayFrequency), timeScale: tweakRayLength )) + mIndexTweak ), uT14 + ( SinOsc.ar( ( uT14 / 2 ), 0 , mul: (( uT14 / ~mindex ) + Env.perc( cosmicRayAttack, 1, tweakRayLevel, -4 ).kr( gate: Dust.ar(cosmicRayFrequency), timeScale: tweakRayLength )) + mIndexTweak )) ], mul: LFNoise1.kr( [ 0.5, 0.5 ], mul: 0.5 ));

nodeEight = SinOsc.ar( [  uT15 + SinOsc.ar( ( uT15 / 2 ), 0 , mul: (( uT15 / ~mindex ) + Env.perc( cosmicRayAttack, 1, tweakRayLevel, -4 ).kr( gate: Dust.ar(cosmicRayFrequency), timeScale: tweakRayLength )) + mIndexTweak ), uT16 + ( SinOsc.ar( ( uT16 / 2 ), 0 , mul: (( uT16 / ~mindex ) + Env.perc( cosmicRayAttack, 1, tweakRayLevel, -4 ).kr( gate: Dust.ar(cosmicRayFrequency), timeScale: tweakRayLength )) + mIndexTweak )) ], mul: LFNoise1.kr( [ 0.5, 0.5 ], mul: 0.5 ));

nodeNine = SinOsc.ar( [  uT17 + SinOsc.ar( ( uT17 / 2 ), 0 , mul: (( uT17 / ~mindex ) + Env.perc( cosmicRayAttack, 1, tweakRayLevel, -4 ).kr( gate: Dust.ar(cosmicRayFrequency), timeScale: tweakRayLength )) + mIndexTweak ), uT18 +( SinOsc.ar( ( uT18 / 2 ), 0 , mul: (( uT18 / ~mindex ) + Env.perc( cosmicRayAttack, 1, tweakRayLevel, -4 ).kr( gate: Dust.ar(cosmicRayFrequency), timeScale: tweakRayLength )) + mIndexTweak )) ], mul: LFNoise1.kr( [ 0.5, 0.5 ], mul: 0.5 ));

nodeTen = SinOsc.ar( [  uT19 + SinOsc.ar( ( uT19 / 2 ), 0 , mul: (( uT19 / ~mindex ) + Env.perc( cosmicRayAttack, 1, tweakRayLevel, -4 ).kr( gate: Dust.ar(cosmicRayFrequency), timeScale: tweakRayLength )) + mIndexTweak ), uT20 + ( SinOsc.ar( ( uT20 / 2 ), 0 , mul: (( uT20 / ~mindex ) + Env.perc( cosmicRayAttack, 1, tweakRayLevel, -4 ).kr( gate: Dust.ar(cosmicRayFrequency), timeScale: tweakRayLength )) + mIndexTweak )) ], mul: LFNoise1.kr( [ 0.5, 0.5 ], mul: 0.5 ));

nodeEleven = SinOsc.ar( [  uT21 + SinOsc.ar( ( uT21 / 2 ), 0 , mul: (( uT21 / ~mindex ) + Env.perc( cosmicRayAttack, 1, tweakRayLevel, -4 ).kr( gate: Dust.ar(cosmicRayFrequency), timeScale: tweakRayLength )) + mIndexTweak ), uT22 + ( SinOsc.ar( ( uT22 / 2 ), 0 , mul: (( uT22 / ~mindex ) + Env.perc( cosmicRayAttack, 1, tweakRayLevel, -4 ).kr( gate: Dust.ar(cosmicRayFrequency), timeScale: tweakRayLength )) + mIndexTweak )) ], mul: LFNoise1.kr( [ 0.5, 0.5 ], mul: 0.5));

nodeTwelve = SinOsc.ar( [  uT23 + SinOsc.ar( ( uT23 / 2 ), 0 , mul: (( uT23 / ~mindex ) + Env.perc( cosmicRayAttack, 1, tweakRayLevel, -4 ).kr( gate: Dust.ar(cosmicRayFrequency), timeScale: tweakRayLength )) + mIndexTweak ), uT24 + ( SinOsc.ar( ( uT24 / 2 ), 0 , mul: (( uT24 / ~mindex ) + Env.perc( cosmicRayAttack, 1, tweakRayLevel, -4 ).kr( gate: Dust.ar(cosmicRayFrequency), timeScale: tweakRayLength )) + mIndexTweak )) ], mul: LFNoise1.kr( [ 0.5, 0.5 ], mul: 0.5 ));


/* ~~~~~~~~~~~~MIX/OUT~~~~~~~~~~~~~ */

signal = Mix.ar([nodeOne,nodeTwo,nodeThree,nodeFour,nodeFive,nodeSix,nodeSeven,nodeEight,nodeNine,nodeTen,nodeEleven,nodeTwelve]);
Out.ar(out,signal*0.1);

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

}).add

)

/* GUI section */

(
var w, f, d, values, server, id, isOn = false;
var b1, b2, s;

values = IdentityDictionary.new;
server = Server.local;

f = { arg name, spec = \lin, guispec;
var height = 20, v, s, n;
guispec = guispec ? spec;
spec = spec.asSpec;
guispec = guispec.asSpec;

v = StaticText(w, Rect(0, 0, 72, height));
v.font = Font("Helvetica", 12);
v.stringColor = Color.black;
v.align = \right;

s = Slider(w, Rect(0, 0, 187, height));
s.resize = 2;
s.action = {
var val, guival, step;
val = spec.map(s.value);
values.put(name, val);
if (isOn, { server.sendMsg("/n_set", id, name, val); });
guival = guispec.map(s.value);
step = pow(10, floor(min(0, guival.abs.log10 - 2)));
v.string = guival.round(step).asString ++ guispec.units;
};
s.value = spec.unmap(spec.default);
s.action.value;

n = StaticText(w, Rect(0, 0, 72, height));n.string = name;
n.stringColor = Color.black;
n.font = Font("Helvetica", 12);
n.resize = 3;

w.view.decorator.nextLine;
};

id = 2001;
w = Window(\focus, Rect(1080, 64, 360, 240));
w.view.decorator = d = FlowLayout(w.view.bounds);

b1 = Button(w, Rect(0,0, 80, 24));
b1.states = [["Load", Color.black, Color.green]];
b1.action = { arg view;
server.sendMsg("/d_load", "synthdefs/ksynProto.scsyndef");
};
b1.enabled = server.serverRunning;
b2 = Button(w, Rect(0,0, 80, 24));
b2.states = [
["Play", Color.new255(0, 191, 255), Color.green],
["Stop", Color.white, Color.red],
];
b2.action = { arg view;
var msg;
if (view.value == 1, {
isOn = true;
msg = ["/s_new", \ksynProto, 2001, 1, 0];
values.keysValuesDo({ arg key, value;
msg = msg.addAll([key, value]);
});
server.performList(\sendMsg, msg);
},{
isOn = false;
server.sendMsg("/n_free", 2001);
});
};
b2.enabled = server.serverRunning;
d.nextLine;

f.value(\microTesla,\lofreq);
f.value(\magnetude,\lofreq);
f.value(\fieldSpread,\lofreq);
f.value(\mIndexTweak,\freq);
f.value(\tweakRayLength,\lofreq);
f.value(\tweakRayLevel,\freq);
f.value(\cosmicRayFrequency,\lofreq);
f.value(\cosmicRayAttack,\lofreq);
// f.value(\oscAmp, \amp, \db);

a = SimpleController(server);
f = { arg server;
b1.enabled = server.serverRunning;
b2.enabled = server.serverRunning;
if (server.serverRunning.not, { b2.value = 0 });
};
a.put(\serverRunning, f);
w.onClose = {
if (isOn, { server.sendMsg("/n_free", 2001) });
a.remove;

};
w.front;
)

/* scope */
s.scope;
FreqScope.new(400, 200, 0, server: s);
